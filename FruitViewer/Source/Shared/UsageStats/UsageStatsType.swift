//
//  UsageStatsType.swift
//  FruitViewer
//
//  Created by John, Melvin (Associate Software Developer) on 25/11/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

import Foundation

enum UsageStatsType {
    case load(UsageStatsLoadInfo)
    case display(UsageStatsDisplayInfo)
    case error(UsageStatsErrorInfo)
    
    func debugLogName() -> String {
        switch self {
        case .display:
            return "display"
        case .error:
            return "error"
        case .load:
            return "load"
        }
    }
}

struct UsageStatsErrorInfo {
    let message: String
}

struct UsageStatsDisplayInfo {
    let requestTime: Int
}

struct UsageStatsLoadInfo {
    let requestTime: Int
}
