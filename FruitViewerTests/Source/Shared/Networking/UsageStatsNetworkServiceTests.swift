//
//  UsageStatsNetworkServiceTests.swift
//  FruitViewerTests

import XCTest
@testable import FruitViewer

class UsageStatsNetworkServiceTests: XCTestCase {
    
    func testUpdateUsageStatsWithNilURL() {
        
        // Given
        let mockSession = MockSession()
        
        let onDataTask = expectation(description: " - onDataTask")
        onDataTask.isInverted = true
        mockSession.onDataTask = { URL, completion in
            onDataTask.fulfill()
        }
        
        let statsNetworkService = UsageStatsNetworkService()
        
        let request = statsNetworkService.updateUsageStats(withURLPath: "", session: mockSession)
        
        do {
            
            // When
            _ = try request { success, error in
                
            }
            
        } catch let error as NetworkServiceError {
            // Then
            switch error {
            case .couldNotBuildURL(URLPath: let urlPath):
                XCTAssertEqual(urlPath, "")
            default:
                XCTFail()
            }
            
        } catch {
            XCTFail()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testUpdateUsageStatsWithNetworkConnectionError() {
        
        // Given
        let mockError = NSError(domain: "", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        
        let mockSession = MockSession()
        
        let onDataTask = expectation(description: " - onDataTask")
        mockSession.onDataTask = { URL, completion in
            onDataTask.fulfill()
            
            completion(nil, nil, mockError)
        }
        
        
        let statsNetworkService = UsageStatsNetworkService()
        
        let request = statsNetworkService.updateUsageStats(withURLPath: "someValidURLPath", session: mockSession)
        
        let onRequestCompletion = expectation(description: " - onRequestCompletion")
        do {
            
            // When
            _ = try request { success, error in
                
                // Then
                XCTAssertFalse(success)
                
                switch error {
                case .some(.noConnection):
                    break
                default:
                    XCTFail()
                }
                
                onRequestCompletion.fulfill()
            }
        
        } catch {
            XCTFail()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testUpdateUsageStatsWithHTTPURLResponse() {
        
        // Given
        
        let mockSession = MockSession()
        
        let onDataTask = expectation(description: " - onDataTask")
        mockSession.onDataTask = { URL, completion in
            onDataTask.fulfill()
            
            completion(nil, nil, nil)
        }
        
        
        let statsNetworkService = UsageStatsNetworkService()
        
        let request = statsNetworkService.updateUsageStats(withURLPath: "someValidURLPath", session: mockSession)
        
        let onRequestCompletion = expectation(description: " - onRequestCompletion")
        do {
            
            // When
            _ = try request { success, error in
                
                // Then
                XCTAssertTrue(success)
                XCTAssertNil(error)
                onRequestCompletion.fulfill()
            }
            
        } catch {
            XCTFail()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testUpdateUsageStatsWithSuccessHTTPResponse() {
        
        // Given
        let mockHTTPResponse = HTTPURLResponse(url: URL(string: "someURL")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        let mockSession = MockSession()
        
        let onDataTask = expectation(description: " - onDataTask")
        mockSession.onDataTask = { URL, completion in
            onDataTask.fulfill()
            
            completion(nil, mockHTTPResponse, nil)
        }
        
        
        let statsNetworkService = UsageStatsNetworkService()
        
        let request = statsNetworkService.updateUsageStats(withURLPath: "someValidURLPath", session: mockSession)
        
        let onRequestCompletion = expectation(description: " - onRequestCompletion")
        do {
            
            // When
            _ = try request { success, error in
                
                // Then
                XCTAssertTrue(success)
                XCTAssertNil(error)
                
                onRequestCompletion.fulfill()
            }
            
        } catch {
            XCTFail()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testUpdateUsageStatsWithServerErrorHTTPResponse() {
        
        // Given
        let mockHTTPResponse = HTTPURLResponse(url: URL(string: "someURL")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        
        let mockSession = MockSession()
        
        let onDataTask = expectation(description: " - onDataTask")
        mockSession.onDataTask = { URL, completion in
            onDataTask.fulfill()
            
            completion(nil, mockHTTPResponse, nil)
        }
        
        
        let statsNetworkService = UsageStatsNetworkService()
        
        let request = statsNetworkService.updateUsageStats(withURLPath: "someValidURLPath", session: mockSession)
        
        let onRequestCompletion = expectation(description: " - onRequestCompletion")
        
        do {
            
            // When
            _ = try request { success, error in
                
                // Then
                XCTAssertFalse(success)
                
                switch error {
                case .some(.HTTPError(let type)):
                    XCTAssertEqual(type, .serverError)
                default:
                    XCTFail()
                }
                
                onRequestCompletion.fulfill()
            }
            
        } catch {
            XCTFail()
        }
        
        waitForExpectations(timeout: 1)
    }

}

class MockURLSessionDataTask: URLSessionDataTask {
    
    var onResume: (() -> Void)?
    
    override func resume() {
        onResume?()
    }
}

class MockSession: URLSession {
    
    var mockURLSessionDataTask = MockURLSessionDataTask()
    
    var onDataTask: ((URL, @escaping (Data?, URLResponse?, Error?) -> Void) -> Void)?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        onDataTask?(url, completionHandler)
        
        return mockURLSessionDataTask
    }
    
}
