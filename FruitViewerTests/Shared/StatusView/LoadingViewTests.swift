//
//  LoadingViewTests.swift
//  FruitViewerTests

import XCTest
@testable import FruitViewer

class LoadingViewTests: XCTestCase {
    
    func testAwakeFromNib() {
        
        let mockUIActivityIndicatorView = MockUIActivityIndicatorView()
        
        let onStartAnimating = expectation(description: " - onStartAnimating")
        mockUIActivityIndicatorView.onStartAnimating = {
            onStartAnimating.fulfill()
        }
        
        let loadingView = LoadingView()
        
        loadingView.activity = mockUIActivityIndicatorView
        
        loadingView.awakeFromNib()
        
        waitForExpectations(timeout: 1)
        
    }
    
}

extension LoadingViewTests {
    
    class MockUIActivityIndicatorView: UIActivityIndicatorView {
        
        var onStartAnimating: (() -> Void)?
        
        override func startAnimating() {
            onStartAnimating?()
        }
    }
}
