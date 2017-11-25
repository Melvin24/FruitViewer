//
//  UsageStatusHandler.swift
//  FruitViewer
//
//  Created by John, Melvin (Associate Software Developer) on 25/11/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

import Foundation

class UsageStatsHandler {
    
    struct UsageStatsNotificationInfoKeys {
        static let stats = "stats"
    }
    
    struct UsageStatsNotificationName {
        static let load = NSNotification.Name(rawValue: "UsageStatsLoad")
        static let display = NSNotification.Name(rawValue: "UsageStatsDisplay")
        static let error = NSNotification.Name(rawValue: "UsageStatsError")
    }
    
    static var shared: UsageStatsHandler = {
        return UsageStatsHandler()
    }()
    
    var notificationCenter = NotificationCenter.default
    
    lazy var networkService = UsageStatsNetworkService()

    private var task: Task?
    
    private var pendingUsageStatsUpdate: [UsageStatsType] = []

    func activate() {
        notificationCenter.addObserver(forName: UsageStatsNotificationName.load , object: nil, queue: nil, using: handleNotification)
        notificationCenter.addObserver(forName: UsageStatsNotificationName.display , object: nil, queue: nil, using: handleNotification)
        notificationCenter.addObserver(forName: UsageStatsNotificationName.error , object: nil, queue: nil, using: handleNotification)
    }
    
    func handleNotification(_ notification: Notification) {
        
        guard notification.name == UsageStatsNotificationName.load ||
              notification.name == UsageStatsNotificationName.display ||
              notification.name == UsageStatsNotificationName.error else {
            return
        }
        
        guard let userInfo = notification.userInfo else {
            return
        }
        
        guard let usageStatsType = userInfo[UsageStatsNotificationInfoKeys.stats] as? UsageStatsType else {
            return
        }
        
        updateUserStats(usingUsageStatsType: usageStatsType)
        
    }
    
    func updateUserStats(usingUsageStatsType usageStatsType: UsageStatsType) {
        let requestURLPath = urlPath(for: usageStatsType)
        
        let request = networkService.updateUsageStats(withURLPath: requestURLPath, session: .shared)
        
        do {
            
            guard task == nil || task?.isRunning == false else {
                pendingUsageStatsUpdate.append(usageStatsType)
                return
            }
            
            task = try request { [weak self] success, error in
                
                // if not successful and an error
                if !success, let error = error  {
                    self?.logNetworkServiceError(error, forUsageStatsType: usageStatsType)
                }
                
                self?.clearPendingUsageStats()
                
            }
            
            task?.resume()
            
        } catch let error as NetworkServiceError {
            self.logNetworkServiceError(error, forUsageStatsType: usageStatsType)
            self.clearPendingUsageStats()
        } catch {
            self.clearPendingUsageStats()
            return
        }
    }
    
    func clearPendingUsageStats() {
        guard !pendingUsageStatsUpdate.isEmpty else {
            return
        }
        
        let lastUsageStats = pendingUsageStatsUpdate.removeLast()
        
        updateUserStats(usingUsageStatsType: lastUsageStats)
    }
    
    func logNetworkServiceError(_ networkServiceError: NetworkServiceError, forUsageStatsType usageStatsType: UsageStatsType) {
        
        var message = "Failed to update \(usageStatsType.debugLogName()), "
        
        switch networkServiceError {
        case.couldNotBuildURL(URLPath: let urlPath):
            message = message + "failed to build \(urlPath)"
        case .noConnection:
            message = message + "no network connection"
        case .HTTPError(type: let response):
            guard response != .success || response != .redirection else {
                return
            }
            message = message + "because of unexpected error, \(response.rawValue)"
        }
    }
    
    func urlPath(for usageStatsType: UsageStatsType) -> String {
        
        let baseURLPath = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/stats?event="
        
        let suffix: String
        
        switch usageStatsType {
        case .display(let displayInfo):
            suffix = "display&data=\(Int(displayInfo.requestTime))"
        case .load(let loadInfo):
            suffix = "load&data=\(Int(loadInfo.requestTime))"
        case .error(let errorInfo):
            
            if let decoratedMessgae = errorInfo.message.addingPercentEncoding(withAllowedCharacters: .alphanumerics) {
                suffix = "error&data=\(decoratedMessgae)"
            } else {
                suffix = "error"
            }
            
        }
        
        return "\(baseURLPath)\(suffix)"

    }
}
