//
//  CanNotifyNetworkRequestDurationTests.swift
//  FruitViewerTests

import XCTest
@testable import FruitViewer

class CanNotifyNetworkRequestDurationTests: XCTestCase {
    
    func testNotifyNetworkRequestDuration() {

        let mockNotificationCentre = MockNotificationCentre()
        
        let onPostNotification = expectation(description: " - onPostNotification")
        mockNotificationCentre.onPost = { notificationName, object, userInfo in
            
            XCTAssertEqual(notificationName, UsageStatsHandler.UsageStatsNotificationName.load)
            XCTAssertNil(object)
            
            guard let usageStats = userInfo?[UsageStatsHandler.UsageStatsNotificationInfoKeys.stats] as? UsageStatsType else {
                return
            }
            
            switch usageStats {
            case .load(let loadInfo):
                XCTAssertEqual(loadInfo.requestTime, 0)
            default:
                XCTFail()
            }
            
            onPostNotification.fulfill()
        }
        
        let mockCanNotifyNetworkRequestDuration = MockCanNotifyNetworkRequestDuration()

        let mockDate = Date()

        mockCanNotifyNetworkRequestDuration.notifyNetworkRequestDuration(startDate: mockDate, endDate: mockDate, notificationCenter: mockNotificationCentre)

        waitForExpectations(timeout: 1)
    }
    
}

extension CanNotifyNetworkRequestDurationTests {
    
    class MockNotificationCentre: NotificationCenter {
        
        var onPost: ((NSNotification.Name, Any?, [AnyHashable: Any]?) -> Void)?

        override func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable : Any]? = nil) {
            onPost?(aName, anObject, aUserInfo)
        }
        
    }
    
    class MockCanNotifyNetworkRequestDuration: CanNotifyNetworkRequestDuration {
    }
    
}
