//
//  CanNotifyDisplayRenderDurationTests.swift
//  FruitViewerTests
//
//  Created by John, Melvin (Associate Software Developer) on 26/11/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

import XCTest
@testable import FruitViewer

class CanNotifyDisplayRenderDurationTests: XCTestCase {
    
    func testNotifyNetworkRequestDuration() {
        
        let mockNotificationCentre = CanNotifyNetworkRequestDurationTests.MockNotificationCentre()
        
        let onPostNotification = expectation(description: " - onPostNotification")
        mockNotificationCentre.onPost = { notificationName, object, userInfo in
            
            XCTAssertEqual(notificationName, UsageStatsHandler.UsageStatsNotificationName.display)
            XCTAssertNil(object)
            
            guard let usageStats = userInfo?[UsageStatsHandler.UsageStatsNotificationInfoKeys.stats] as? UsageStatsType else {
                return
            }
            
            switch usageStats {
            case .display(let loadInfo):
                XCTAssertEqual(loadInfo.requestTime, 0)
            default:
                XCTFail()
            }
            
            onPostNotification.fulfill()
        }
        
        let mockCanNotifyNetworkRequestDuration = MockCanNotifyDisplayRenderDuration()
        
        let mockDate = Date()
        
        mockCanNotifyNetworkRequestDuration.notifyDisplayRenderDuration(startDate: mockDate, endDate: mockDate, notificationCenter: mockNotificationCentre)
        
        waitForExpectations(timeout: 1)
    }
    
}

extension CanNotifyDisplayRenderDurationTests {

    class MockCanNotifyDisplayRenderDuration: CanNotifyDisplayRenderDuration {
    }
    
}
