//
//  CanHandleDisaplyUsageStats.swift
//  FruitViewer
//
//  Created by John, Melvin (Associate Software Developer) on 25/11/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

import Foundation

protocol SupportDisaplyUsageStatsUpdate {
    
    var userInitiatedDate: Date! { get set }
    
    var finishedDisplayRenderDate: Date! { get set }
        
}
