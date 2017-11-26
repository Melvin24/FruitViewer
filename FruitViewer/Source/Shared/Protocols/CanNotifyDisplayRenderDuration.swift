//
//  CanNotifyDisplayRenderDuration.swift
//  FruitViewer

import Foundation

protocol CanNotifyDisplayRenderDuration {
    
    func notifyDisplayRenderDuration(startDate: Date, endDate: Date, notificationCenter: NotificationCenter) -> Void
    
}

extension CanNotifyDisplayRenderDuration {
    
    func notifyDisplayRenderDuration(startDate: Date, endDate: Date, notificationCenter: NotificationCenter = .default) -> Void {
        
        let executionTime = endDate.timeIntervalSince(startDate)
        
        let requestTime = round(executionTime*1000)
        
        let key = UsageStatsHandler.UsageStatsNotificationInfoKeys.stats
        
        let userInfo: [AnyHashable: Any] = [key: UsageStatsType.display(UsageStatsDisplayInfo(requestTime: Int(requestTime)))]
        
        notificationCenter.post(name: UsageStatsHandler.UsageStatsNotificationName.display,
                              object: nil,
                            userInfo: userInfo)
    }
}
