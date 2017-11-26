//
//  FruitListInteractorTests.swift
//  FruitViewerTests

import XCTest
@testable import FruitViewer

class FruitListInteractorTests: XCTestCase {
    
    func testFetchDataWithTaskAlreadyRunning() {
        
        let mockTask = MockTask()
        
        let onResume = expectation(description: " - onResume")
        onResume.isInverted = true
        mockTask.onResume = {
            onResume.fulfill()
        }
        
        mockTask.isRunning = true
        
        let interactor = FruitListInteractor { completion in
            return mockTask
        }
        
        interactor.task = mockTask
        
        let onFetchData = expectation(description: " - onFetchData")
        onFetchData.isInverted = true
        interactor.fetchData { _ in
            onFetchData.fulfill()
            XCTFail()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchDataWithExceptionThrown() {
        
        let mockTask = MockTask()
        
        let onResume = expectation(description: " - onResume")
        onResume.isInverted = true
        mockTask.onResume = {
            onResume.fulfill()
        }
        
        let interactor = FruitListInteractor { completion in
            throw NetworkServiceError.noConnection
        }
        
        let onFetchData = expectation(description: " - onFetchData")
        interactor.fetchData { result in
            
            switch result {
            case .failure(let error) where error is NetworkServiceError:
                break
                
            case _:
                XCTFail()
                
            }
            
            onFetchData.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchData() {
        
        let mockTask = MockTask()
        
        let onResume = expectation(description: " - onResume")
        mockTask.onResume = {
            onResume.fulfill()
        }
        
        let interactor = FruitListInteractor { completion in
            completion(.success([Fruit]()))
            return mockTask
        }
        
        let onFetchData = expectation(description: " - onFetchData")
        interactor.fetchData { result in
            
            switch result {
            case .success(let fruits):
                XCTAssertEqual(fruits.count, 0)
                
            case _:
                XCTFail()
                
            }
            
            onFetchData.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
}

extension FruitListInteractorTests {
    
    class MockTask: Task {
        
        var onResume: (() -> Void)?
        
        var isRunning: Bool = false
        
        func resume() {
            onResume?()
        }
        
        func cancel() {
        }
    }
    
}
