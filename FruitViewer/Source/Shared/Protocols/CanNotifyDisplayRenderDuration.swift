//
//  CanNotifyDisplayRenderDuration.swift
//  FruitViewer
//
//  Created by John, Melvin (Associate Software Developer) on 25/11/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

import Foundation

protocol CanNotifyDisplayRenderDuration {
    
    func notifyDisplayRenderDuration(startDate: Date, endDate: Date) -> Void
    
}

extension CanNotifyDisplayRenderDuration {
    
    func notifyDisplayRenderDuration(startDate: Date, endDate: Date) -> Void {
        
        let executionTime = endDate.timeIntervalSince(startDate)
        
        let requestTime = round(executionTime*1000)
        
        let key = UsageStatsHandler.UsageStatsNotificationInfoKeys.stats
        
        let userInfo: [AnyHashable: Any] = [key: UsageStatsType.display(UsageStatsDisplayInfo(requestTime: Int(requestTime)))]
        
        NotificationCenter.default.post(name: UsageStatsHandler.UsageStatsNotificationName.display,
                                      object: nil,
                                    userInfo: userInfo)
    }
}
