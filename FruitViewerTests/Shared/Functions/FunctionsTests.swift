//
//  FunctionsTests.swift
//  FruitViewerTests
//
//  Created by John, Melvin (Associate Software Developer) on 26/11/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

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
