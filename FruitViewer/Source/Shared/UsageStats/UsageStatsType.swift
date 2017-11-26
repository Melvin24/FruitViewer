//
//  UsageStatsType.swift
//  FruitViewer

import Foundation

/// Enum to represent different types of usage stats.
enum UsageStatsType {
    
    /// For network request load time
    case load(UsageStatsLoadInfo)
    
    /// For Display render load time.
    case display(UsageStatsDisplayInfo)
    
    /// For exceptions.
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
