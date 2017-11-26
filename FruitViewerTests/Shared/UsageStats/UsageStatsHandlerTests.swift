//
//  UsageStatsHandlerTests.swift
//  FruitViewerTests

import XCTest
@testable import FruitViewer

class UsageStatsHandlerTests: XCTestCase {
    
    func testActivate() {
        
        let handler = UsageStatsHandler()
        
        let mockNotificationCentre = MockNotificationCentre()
        
        let loadAddObserver = expectation(description: " - loadAddObserver")
        let displayAddObserver = expectation(description: " - displayAddObserver")
        let errorAddObserver = expectation(description: " - errorAddObserver")

        mockNotificationCentre.onAddObserver = { name, object, queue in
            if name == UsageStatsHandler.UsageStatsNotificationName.load {
                loadAddObserver.fulfill()
            } else if name == UsageStatsHandler.UsageStatsNotificationName.display {
                displayAddObserver.fulfill()
            } else if name == UsageStatsHandler.UsageStatsNotificationName.error {
                errorAddObserver.fulfill()
            } else {
                XCTFail()
            }
        }
        
        handler.notificationCenter = mockNotificationCentre
        
        handler.activate()
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testHandleNotificationWithInvalidName() {
        
        let handler = UsageStatsHandler()

        let onUpdateUserStatsUsingUsageStats = expectation(description: " - onUpdateUserStatsUsingUsageStats")
        onUpdateUserStatsUsingUsageStats.isInverted = true
        handler.updateUserStatsUsingUsageStats = { handler in
            return { usageStats in
                onUpdateUserStatsUsingUsageStats.fulfill()
            }
        }
        
        handler.handleNotification(Notification(name: .NSCalendarDayChanged))
        
        waitForExpectations(timeout: 1)
    }
    
    func testHandleNotificationWithNoUserInfo() {
        
        let handler = UsageStatsHandler()
        
        let onUpdateUserStatsUsingUsageStats = expectation(description: " - onUpdateUserStatsUsingUsageStats")
        onUpdateUserStatsUsingUsageStats.isInverted = true
        handler.updateUserStatsUsingUsageStats = { handler in
            return { usageStats in
                onUpdateUserStatsUsingUsageStats.fulfill()
            }
        }
        
        handler.handleNotification(Notification(name: UsageStatsHandler.UsageStatsNotificationName.load))
        
        waitForExpectations(timeout: 1)
    }
    
    func testHandleNotificationWithInvalidUserInfo() {
        
        let handler = UsageStatsHandler()
        
        let onUpdateUserStatsUsingUsageStats = expectation(description: " - onUpdateUserStatsUsingUsageStats")
        onUpdateUserStatsUsingUsageStats.isInverted = true
        handler.updateUserStatsUsingUsageStats = { handler in
            return { usageStats in
                onUpdateUserStatsUsingUsageStats.fulfill()
            }
        }
        
        handler.handleNotification(Notification(name: UsageStatsHandler.UsageStatsNotificationName.load,
                                                object: nil,
                                                userInfo: ["invalid": "value"]))
        
        waitForExpectations(timeout: 1)
    }
    
    func testHandleNotification() {
        
        let handler = UsageStatsHandler()
        
        let onUpdateUserStatsUsingUsageStats = expectation(description: " - onUpdateUserStatsUsingUsageStats")
        handler.updateUserStatsUsingUsageStats = { handler in
            return { usageStats in
                switch usageStats {
                case .load(let info):
                    XCTAssertEqual(info.requestTime, 12)
                default:
                    XCTFail()
                }
                onUpdateUserStatsUsingUsageStats.fulfill()
            }
        }
        
        handler.handleNotification(Notification(name: UsageStatsHandler.UsageStatsNotificationName.load,
                                                object: nil,
                                                userInfo: ["stats": UsageStatsType.load(UsageStatsLoadInfo(requestTime: 12))]))
        
        waitForExpectations(timeout: 1)
    }
    
    func testUpdateUserStatsWithNetworkServiceErrorThrown() {
        
        // Given
        let mockNetworkservice = MockNetworkservice()
        
        let onUpdateUsageStats = expectation(description: " - onUpdateUsageStats")
        mockNetworkservice.onUpdateUsageStats = { urlPath, session in
            return { completion in
                onUpdateUsageStats.fulfill()
                
                // Then
                throw NetworkServiceError.noConnection
            }
        }
        
        let handler = UsageStatsHandler()
        
        handler.networkService = mockNetworkservice
        
        /// Avoiding Dispatch group
        handler.dispatchGroupForUsageStatsType = { _ in
            return nil
        }
        
        let onLogNetworkRequestError = expectation(description: " - onLogNetworkRequestError")
        handler.logNetworkRequestError = { _ in
            return { error, usageStatsType in
                switch error {
                case .noConnection:
                    break
                default:
                    XCTFail()
                }
                
                switch usageStatsType {
                case .load(let info):
                    XCTAssertEqual(info.requestTime, 12)
                default:
                    XCTFail()
                }
                
                onLogNetworkRequestError.fulfill()
            }
        }
        
        let onExecutePendingUsageStats = expectation(description: " - executePendingUsageStats")
        handler.executePendingUsageStats = { _ in
            return {
                onExecutePendingUsageStats.fulfill()
            }
        }
        
        // When
        handler.updateUserStats(usingUsageStatsType: .load(UsageStatsLoadInfo(requestTime: 12)))

        waitForExpectations(timeout: 1)
        
    }
    
    func testUpdateUserStatsWithUnexpectedErrorThrown() {
        
        // Given
        let mockNetworkservice = MockNetworkservice()
        
        let onUpdateUsageStats = expectation(description: " - onUpdateUsageStats")
        mockNetworkservice.onUpdateUsageStats = { urlPath, session in
            return { completion in
                onUpdateUsageStats.fulfill()
                
                // Then
                throw FruitDataNetworkService.FruitDataNetworkingError.noData
            }
        }
        
        let handler = UsageStatsHandler()
        
        handler.networkService = mockNetworkservice
        
        /// Avoiding Dispatch group
        handler.dispatchGroupForUsageStatsType = { _ in
            return nil
        }
        
        let onLogNetworkRequestError = expectation(description: " - onLogNetworkRequestError")
        onLogNetworkRequestError.isInverted = true
        handler.logNetworkRequestError = { _ in
            return { error, usageStatsType in
                onLogNetworkRequestError.fulfill()
            }
        }
        
        let onExecutePendingUsageStats = expectation(description: " - executePendingUsageStats")
        handler.executePendingUsageStats = { _ in
            return {
                onExecutePendingUsageStats.fulfill()
            }
        }
        
        // When
        handler.updateUserStats(usingUsageStatsType: .load(UsageStatsLoadInfo(requestTime: 12)))
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testUpdateUserStatsWithSuccessfulResponse() {
        
        // Given
        let mockTask = MockTask()
        
        let onResume = expectation(description: " - onResume")
        mockTask.onResume = {
            onResume.fulfill()
        }
        
        let mockNetworkservice = MockNetworkservice()
        
        let onUpdateUsageStats = expectation(description: " - onUpdateUsageStats")
        mockNetworkservice.onUpdateUsageStats = { urlPath, session in
            return { completion in
                
                /// Then
                onUpdateUsageStats.fulfill()
                completion(true, nil)
                return mockTask
            }
        }
        
        let handler = UsageStatsHandler()
        
        handler.networkService = mockNetworkservice
        
        /// Avoiding Dispatch group
        handler.dispatchGroupForUsageStatsType = { _ in
            return nil
        }
        
        let onLogNetworkRequestError = expectation(description: " - onLogNetworkRequestError")
        onLogNetworkRequestError.isInverted = true
        handler.logNetworkRequestError = { _ in
            return { error, usageStatsType in
                onLogNetworkRequestError.fulfill()
            }
        }
        
        let onExecutePendingUsageStats = expectation(description: " - executePendingUsageStats")
        handler.executePendingUsageStats = { _ in
            return {
                onExecutePendingUsageStats.fulfill()
            }
        }
        
        // When
        handler.updateUserStats(usingUsageStatsType: .load(UsageStatsLoadInfo(requestTime: 12)))
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testUpdateUserStatsWithUnSuccessfulResponse() {
        
        // Given
        let mockTask = MockTask()
        
        let onResume = expectation(description: " - onResume")
        mockTask.onResume = {
            onResume.fulfill()
        }
        
        let mockNetworkservice = MockNetworkservice()
        
        let onUpdateUsageStats = expectation(description: " - onUpdateUsageStats")
        mockNetworkservice.onUpdateUsageStats = { urlPath, session in
            return { completion in
                
                /// Then
                onUpdateUsageStats.fulfill()
                completion(false, .noConnection)
                return mockTask
            }
        }
        
        let handler = UsageStatsHandler()
        
        handler.networkService = mockNetworkservice
        
        /// Avoiding Dispatch group
        handler.dispatchGroupForUsageStatsType = { _ in
            return nil
        }
        
        let onLogNetworkRequestError = expectation(description: " - onLogNetworkRequestError")
        handler.logNetworkRequestError = { _ in
            return { error, usageStatsType in
                switch error {
                case .noConnection:
                    break
                default:
                    XCTFail()
                }
                
                switch usageStatsType {
                case .load(let info):
                    XCTAssertEqual(info.requestTime, 12)
                default:
                    XCTFail()
                }
                
                onLogNetworkRequestError.fulfill()
            }
        }
        
        let onExecutePendingUsageStats = expectation(description: " - executePendingUsageStats")
        handler.executePendingUsageStats = { _ in
            return {
                onExecutePendingUsageStats.fulfill()
            }
        }
        
        // When
        handler.updateUserStats(usingUsageStatsType: .load(UsageStatsLoadInfo(requestTime: 12)))
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testURLPathForDisplayUsageStatsType() {
        let usageStatsType = UsageStatsType.display(UsageStatsDisplayInfo(requestTime: 123))
        
        let handler = UsageStatsHandler()
        
        let actualResponse = handler.urlPath(for: usageStatsType)
        
        let expectedResponse = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/stats?event=display&data=123"
        
        XCTAssertEqual(actualResponse, expectedResponse)
        
    }
    
    func testURLPathForLoadUsageStatsType() {
        let usageStatsType = UsageStatsType.load(UsageStatsLoadInfo(requestTime: 123))
        
        let handler = UsageStatsHandler()
        
        let actualResponse = handler.urlPath(for: usageStatsType)
        
        let expectedResponse = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/stats?event=load&data=123"
        
        XCTAssertEqual(actualResponse, expectedResponse)
        
    }
    
    func testURLPathForErrorUsageStatsType() {
        let usageStatsType = UsageStatsType.error(UsageStatsErrorInfo(message: "some crash message"))
        
        let handler = UsageStatsHandler()
        
        let actualResponse = handler.urlPath(for: usageStatsType)
        
        let expectedResponse = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/stats?event=error&data=some%20crash%20message"
        
        XCTAssertEqual(actualResponse, expectedResponse)
        
    }
    
}

extension UsageStatsHandlerTests {
    
    class MockTask: Task {
        
        var isRunning: Bool = false
        
        var onResume: (() -> Void)?
        func resume() {
            onResume?()
        }
        
        func cancel() {
        }
    }
    
    class MockNetworkservice: UsageStatsNetworkService {
        
        var onUpdateUsageStats: ((String, URLSession) -> UsageStatsNetworkService.Request) = { urlPath, session in
            return { completion in
                
                return MockTask()
            }
        }
        override func updateUsageStats(withURLPath URLPath: String, session: URLSession) -> UsageStatsNetworkService.Request {
            return onUpdateUsageStats(URLPath, session)
        }
        
    }
    
    
    class MockNotificationCentre: NotificationCenter {
        
        var onAddObserver: ((NSNotification.Name?, Any?, OperationQueue?) -> Void)?
        
        override func addObserver(forName name: NSNotification.Name?, object obj: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> Void) -> NSObjectProtocol {
            
            onAddObserver?(name, obj, queue)
            
            return super.addObserver(forName: name, object: nil, queue: nil) { _ in
                /// do nothing
            }
        }
        
    }
}
