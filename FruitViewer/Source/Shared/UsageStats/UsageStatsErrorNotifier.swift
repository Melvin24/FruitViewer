//
//  UsageStatsErrorNotifier.swift
//  FruitViewer
//
//  Created by John, Melvin (Associate Software Developer) on 25/11/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

import Foundation

@objc
class UsageStatsErrorNotifier: NSObject {
    
    @objc
    static func notifyException(_ exception: NSException) {
        
        let message = exception.reason
        
        let key = UsageStatsHandler.UsageStatsNotificationInfoKeys.stats
        
        let userInfo: [AnyHashable: Any] = [key: UsageStatsType.error(UsageStatsErrorInfo(message: message ?? ""))]
        
        NotificationCenter.default.post(name: UsageStatsHandler.UsageStatsNotificationName.error,
                                        object: nil,
                                        userInfo: userInfo)
        
    }
}
