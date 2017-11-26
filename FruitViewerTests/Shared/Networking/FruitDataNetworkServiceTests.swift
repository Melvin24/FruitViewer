//
//  FruitDataNetworkServiceTests.swift
//  FruitViewerTests
//
//  Created by John, Melvin (Associate Software Developer) on 26/11/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

import XCTest
@testable import FruitViewer

class FruitDataNetworkServiceTests: XCTestCase {
    
    func testUpdateUsageStatsWithNilURL() {
        
        // Given
        let mockSession = MockSession()
        
        let onDataTask = expectation(description: " - onDataTask")
        onDataTask.isInverted = true
        mockSession.onDataTask = { URL, completion in
            onDataTask.fulfill()
        }
        
        let fruitDataNetworkService = FruitDataNetworkService()
        
        fruitDataNetworkService.URLPath = ""
        
        let request = fruitDataNetworkService.fetchFruitData(session: mockSession)
        
        do {
            
            // When
            _ = try request { result in
                
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
    
    func testUpdateUsageStatsWithConnectionError() {
        
        // Given
        let mockError = NSError(domain: "", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        
        let mockSession = MockSession()
        
        let onDataTask = expectation(description: " - onDataTask")
        mockSession.onDataTask = { URL, completion in
            onDataTask.fulfill()
            
            completion(nil, nil, mockError)
        }
        
        
        let fruitDataNetworkService = FruitDataNetworkService()

        fruitDataNetworkService.URLPath = "someValidURLPath"
        
        let request = fruitDataNetworkService.fetchFruitData(session: mockSession)

        let onRequestCompletion = expectation(description: " - onRequestCompletion")
        do {
            
            // When
            _ = try request { result in
                
                // Then
                switch result {
                case .failure(let error):
                    if case let networkError as NetworkServiceError = error {
                        
                        switch networkError {
                        case .noConnection:
                            break
                        default:
                            XCTFail()
                        }
                        
                    } else {
                        XCTFail()
                    }
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
    
    func testUpdateUsageStatsWithNoData() {
        
        // Given
        let mockSession = MockSession()
        
        let onDataTask = expectation(description: " - onDataTask")
        mockSession.onDataTask = { URL, completion in
            onDataTask.fulfill()
            
            completion(nil, nil, nil)
        }
        
        
        let fruitDataNetworkService = FruitDataNetworkService()
        
        fruitDataNetworkService.URLPath = "someValidURLPath"
        
        let request = fruitDataNetworkService.fetchFruitData(session: mockSession)
        
        let onRequestCompletion = expectation(description: " - onRequestCompletion")
        do {
            
            // When
            _ = try request { result in
                
                // Then
                switch result {
                case .failure(let error):
                    if case let fruitDataNetworkingError as FruitDataNetworkService.FruitDataNetworkingError = error {
                        
                        switch fruitDataNetworkingError {
                        case .noData:
                            break
                        default:
                            XCTFail()
                        }
                        
                    } else {
                        XCTFail()
                    }
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
    
    func testUpdateUsageStatsWithUnableToDecode() {
        
        // Given
        
        let invalidJSONData = """
        {
            "fruit":[
                {"type":"apple", "price":149, "weight":120}
                {"type":"banana", "price":129, "weight":80}
            ]
        }
        """.data(using: .utf8)!
        
        let mockSession = MockSession()
        
        let onDataTask = expectation(description: " - onDataTask")
        mockSession.onDataTask = { URL, completion in
            onDataTask.fulfill()
            
            completion(invalidJSONData, nil, nil)
        }
        
        
        let fruitDataNetworkService = FruitDataNetworkService()
        
        fruitDataNetworkService.URLPath = "someValidURLPath"
        
        let request = fruitDataNetworkService.fetchFruitData(session: mockSession)
        
        let onRequestCompletion = expectation(description: " - onRequestCompletion")
        do {
            
            // When
            _ = try request { result in
                
                // Then
                switch result {
                case .failure(let error):
                    if case let fruitDataNetworkingError as FruitDataNetworkService.FruitDataNetworkingError = error {
                        
                        switch fruitDataNetworkingError {
                        case .unableToParseData:
                            break
                        default:
                            XCTFail()
                        }
                        
                    } else {
                        XCTFail()
                    }
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
    
    func testUpdateUsageStats() {
        
        // Given
        
        let validJSONData = """
        {
            "fruit":[
                {"type":"apple", "price":149, "weight":120},
                {"type":"banana", "price":129, "weight":80}
            ]
        }
        """.data(using: .utf8)!
        
        let mockSession = MockSession()
        
        let onDataTask = expectation(description: " - onDataTask")
        mockSession.onDataTask = { URL, completion in
            onDataTask.fulfill()
            
            completion(validJSONData, nil, nil)
        }
        
        
        let fruitDataNetworkService = FruitDataNetworkService()
        
        fruitDataNetworkService.URLPath = "someValidURLPath"
        
        let request = fruitDataNetworkService.fetchFruitData(session: mockSession)
        
        let onRequestCompletion = expectation(description: " - onRequestCompletion")
        do {
            
            // When
            _ = try request { result in
                
                // Then
                switch result {
                case .success(let fruits):
                    XCTAssertEqual(fruits.count, 2)
                    
                    let fruitOne = fruits[0]
                    XCTAssertEqual(fruitOne.name, "apple")
                    XCTAssertEqual(fruitOne.weight, 120)
                    XCTAssertEqual(fruitOne.price, 149)
                    
                    let fruitTwo = fruits[1]
                    XCTAssertEqual(fruitTwo.name, "banana")
                    XCTAssertEqual(fruitTwo.weight, 80)
                    XCTAssertEqual(fruitTwo.price, 129)

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
