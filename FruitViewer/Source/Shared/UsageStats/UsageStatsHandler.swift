//
//  UsageStatusHandler.swift
//  FruitViewer

import Foundation

/// Responsibe for managing Usage stats such as netowrk request load time, display time and error. 
class UsageStatsHandler {
    
    struct UsageStatsNotificationInfoKeys {
        static let stats = "stats"
    }
    
    /// Usage Stats Notification Names
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
    
    deinit {
        notificationCenter.removeObserver(self, name: UsageStatsNotificationName.load, object: nil)
        notificationCenter.removeObserver(self, name: UsageStatsNotificationName.display, object: nil)
        notificationCenter.removeObserver(self, name: UsageStatsNotificationName.error, object: nil)
    }

    /// Call this method to activate Usage stats, to start listening got Usage notifications.
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
        
        updateUserStatsUsingUsageStats(self)(usageStatsType)
        
    }
    
    func updateUserStats(usingUsageStatsType usageStatsType: UsageStatsType) {
        let requestURLPath = urlPath(for: usageStatsType)
        
        let request = networkService.updateUsageStats(withURLPath: requestURLPath, session: .shared)
        
        do {
            
            guard task == nil || task?.isRunning == false else {
                pendingUsageStatsUpdate.append(usageStatsType)
                return
            }
            
            let dispatchGroup = dispatchGroupForUsageStatsType(usageStatsType)
            
            /// Setting up dispatch group to give the app a chance to perform network request.
            dispatchGroup?.enter()
            
            task = try request { [weak self] success, error in
                
                /// As soon as request completion, un-block current thread.
                dispatchGroup?.leave()
                
                guard let strongSelf = self else {
                    return
                }
                
                // if not successful and an error
                if !success, let error = error  {
                    strongSelf.logNetworkRequestError(strongSelf)(error, usageStatsType)
                }
                
                strongSelf.executePendingUsageStats(strongSelf)()
                
            }
            
            task?.resume()
            
            _ = dispatchGroup?.wait(timeout: DispatchTime.now() + 3)

        } catch let error as NetworkServiceError {
            logNetworkRequestError(self)(error, usageStatsType)
            executePendingUsageStats(self)()
        } catch {
            executePendingUsageStats(self)()
            return
        }
    }
    
    /// Responsible for manging any pending usage stats
    func clearPendingUsageStats() {
        guard !pendingUsageStatsUpdate.isEmpty else {
            return
        }
        
        let lastUsageStats = pendingUsageStatsUpdate.removeLast()
        
        updateUserStats(usingUsageStatsType: lastUsageStats)
    }
    
    /// Responsible for providing request URL for a give usage stats type.
    func urlPath(for usageStatsType: UsageStatsType) -> String {
        
        let baseURLPath = "\(RequestURL.basePath)/stats?event="
        
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
    
    /// Responsible for logging any unexpected network request failures. 
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
        
        print(message)
        
    }
    
    // TEST INJECTION

    var dispatchGroupForUsageStatsType: ((UsageStatsType) -> DispatchGroup?) = { usageStatsType in
        switch usageStatsType {
        case .error:
            return DispatchGroup()
        default:
            return nil
        }
    }
    
    var updateUserStatsUsingUsageStats = UsageStatsHandler.updateUserStats
    var executePendingUsageStats = UsageStatsHandler.clearPendingUsageStats
    var logNetworkRequestError = UsageStatsHandler.logNetworkServiceError
}
