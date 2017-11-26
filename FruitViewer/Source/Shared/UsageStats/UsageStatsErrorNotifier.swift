//
//  UsageStatsErrorNotifier.swift
//  FruitViewer

import Foundation

@objc
class UsageStatsErrorNotifier: NSObject {
    
    @objc
    static func notifyException(_ exception: NSException, notificationCenter: NotificationCenter = .default) {
        
        let message = exception.reason
        
        let key = UsageStatsHandler.UsageStatsNotificationInfoKeys.stats
        
        let userInfo: [AnyHashable: Any] = [key: UsageStatsType.error(UsageStatsErrorInfo(message: message ?? ""))]
        
        notificationCenter.post(name: UsageStatsHandler.UsageStatsNotificationName.error,
                              object: nil,
                            userInfo: userInfo)
        
    }
}
