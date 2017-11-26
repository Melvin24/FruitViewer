//
//  InteractorTests.swift
//  FruitViewerTests
//
//  Created by John, Melvin (Associate Software Developer) on 25/11/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

import XCTest
@testable import FruitViewer

class InteractorTests: XCTestCase {
    
    func testInvalidate() {
    
        let mockTask = MockTask()
        
        let onCancel = expectation(description: " - onCancel")
        mockTask.onCancel = {
            onCancel.fulfill()
        }
        
        let mockInteractor = MockInteractor()
        
        mockInteractor.task = mockTask
        
        mockInteractor.invalidateFetch()
        
        waitForExpectations(timeout: 1)
    }

}

extension InteractorTests {
    
    class MockTask: Task {
        
        var onCancel: (() -> Void)?
        
        var isRunning: Bool = false

        func resume() {
        }
        
        func cancel() {
            onCancel?()
        }
    }
    
    class MockInteractor: Interactor {
        
        var task: Task?
        
        func fetchData(completion: @escaping (Result<String>) -> Void) {
            
        }
        
    }
}
