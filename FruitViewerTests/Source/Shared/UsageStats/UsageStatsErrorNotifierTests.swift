//
//  UsageStatsErrorNotifierTests.swift
//  FruitViewerTests

import XCTest
@testable import FruitViewer

class UsageStatsErrorNotifierTests: XCTestCase {
    
    func testNotifyException() {
        
        let mockNotificationCentre = MockNotificationCentre()
        
        let onPostNotification = expectation(description: " - onPostNotification")
        mockNotificationCentre.onPost = { notificationName, object, userInfo in
            
            XCTAssertEqual(notificationName, UsageStatsHandler.UsageStatsNotificationName.error)
            XCTAssertNil(object)
            
            guard let usageStats = userInfo?[UsageStatsHandler.UsageStatsNotificationInfoKeys.stats] as? UsageStatsType else {
                return
            }
            
            switch usageStats {
            case .error(let errorInfo):
                XCTAssertEqual(errorInfo.message, "some reason")
            default:
                XCTFail()
            }
            
            onPostNotification.fulfill()
        }
        
        let mockException = NSException(name: .characterConversionException, reason: "some reason", userInfo: nil)
        
        UsageStatsErrorNotifier.notifyException(mockException, notificationCenter: mockNotificationCentre)
        
        waitForExpectations(timeout: 1)
        
    }
    
}

extension UsageStatsErrorNotifierTests {
    
    class MockNotificationCentre: NotificationCenter {
        
        var onPost: ((NSNotification.Name, Any?, [AnyHashable: Any]?) -> Void)?
        
        override func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable : Any]? = nil) {
            onPost?(aName, anObject, aUserInfo)
        }
        
    }
    
}
