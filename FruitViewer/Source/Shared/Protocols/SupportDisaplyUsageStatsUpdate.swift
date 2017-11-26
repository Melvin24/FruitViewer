//
//  CanHandleDisaplyUsageStats.swift
//  FruitViewer

import Foundation

protocol SupportDisaplyUsageStatsUpdate {
    
    var userInitiatedDate: Date! { get set }
    
    var finishedDisplayRenderDate: Date! { get set }
        
}
