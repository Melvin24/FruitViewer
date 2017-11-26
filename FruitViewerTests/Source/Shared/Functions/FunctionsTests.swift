//
//  FunctionsTests.swift
//  FruitViewerTests

import XCTest
@testable import FruitViewer

class FunctionsTests: XCTestCase {
    
    func testAppleClassesDoNotHaveAModulePrefix() {
        let className = classNameFromType(NSString.self)
        
        XCTAssertEqual(className, "NSString")
    }
    
    func testSkySportsClassesDoHaveAModulePrefix() {
        let className = classNameFromType(FruitViewer.AppDelegate.self)
        
        XCTAssertEqual(className, "AppDelegate")
    }
    
}
