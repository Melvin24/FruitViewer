//
//  CanNotifyNetworkRequestDuration.swift
//  FruitViewer

import Foundation

protocol CanNotifyNetworkRequestDuration {
    
    func notifyNetworkRequestDuration(startDate: Date, endDate: Date, notificationCenter: NotificationCenter) -> Void
    
}

extension CanNotifyNetworkRequestDuration {
    
    func notifyNetworkRequestDuration(startDate: Date, endDate: Date, notificationCenter: NotificationCenter = .default) -> Void {
        
       let executionTime = endDate.timeIntervalSince(startDate)
        
        let requestTime = round(executionTime*1000)
        
        let key = UsageStatsHandler.UsageStatsNotificationInfoKeys.stats
        
        let userInfo: [AnyHashable: Any] = [key: UsageStatsType.load(UsageStatsLoadInfo(requestTime: Int(requestTime)))]
        
        notificationCenter.post(name: UsageStatsHandler.UsageStatsNotificationName.load,
                              object: nil,
                            userInfo: userInfo)
    }
}
