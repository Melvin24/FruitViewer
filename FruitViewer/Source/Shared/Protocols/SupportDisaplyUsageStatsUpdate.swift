//
//  CanHandleDisaplyUsageStats.swift
//  FruitViewer

import Foundation

/// A Protocol to represent Display Render Time fro Usage Stats.
protocol SupportDisaplyUsageStatsUpdate {
    
    /// User's initiated date.
    var userInitiatedDate: Date! { get set }
    
    /// Render complete date.
    var finishedDisplayRenderDate: Date! { get set }
        
}
