//
//  FruitDataTests.swift
//  FruitViewerTests
//
//  Created by John, Melvin (Associate Software Developer) on 26/11/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

import XCTest
@testable import FruitViewer

class FruitDataTests: XCTestCase {
    
    func testFruitData() {
        
        let jsonData = """
        {
            "fruit":[
                {"type":"apple", "price":149, "weight":120},
                {"type":"banana", "price":129, "weight":80},
                {"type":"blueberry", "price":19, "weight":18},
                {"type":"orange", "price":199, "weight":150},
                {"type":"pear", "price":99, "weight":100},
                {"type":"strawberry", "price":99, "weight":20},
                {"type":"kumquat", "price":49, "weight":80},
                {"type":"pitaya", "price":599, "weight":100},
                {"type":"kiwi", "price":89, "weight":200},
                {"type": "newFruit", "price": 76, "weight": 700}
            ]
        }
        """.data(using: .utf8)!
        
        let fruitData = try? JSONDecoder().decode(FruitData.self, from: jsonData)
        
        XCTAssertNotNil(fruitData)
        
        _ = fruitData?.fruits.enumerated().map { tuple in
            
            switch tuple.offset {
            case 0:
                XCTAssertNotNil(tuple.element.image)
                XCTAssertEqual(tuple.element.name, "apple")
                XCTAssertEqual(tuple.element.weight, 120)
                XCTAssertEqual(tuple.element.type, .apple)
                XCTAssertEqual(tuple.element.price, 149)
            case 1:
                XCTAssertNotNil(tuple.element.image)
                XCTAssertEqual(tuple.element.name, "banana")
                XCTAssertEqual(tuple.element.weight, 80)
                XCTAssertEqual(tuple.element.type, .banana)
                XCTAssertEqual(tuple.element.price, 129)
            case 2:
                XCTAssertNotNil(tuple.element.image)
                XCTAssertEqual(tuple.element.name, "blueberry")
                XCTAssertEqual(tuple.element.weight, 18)
                XCTAssertEqual(tuple.element.type, .blueberry)
                XCTAssertEqual(tuple.element.price, 19)
            case 3:
                XCTAssertNotNil(tuple.element.image)
                XCTAssertEqual(tuple.element.name, "orange")
                XCTAssertEqual(tuple.element.weight, 150)
                XCTAssertEqual(tuple.element.type, .orange)
                XCTAssertEqual(tuple.element.price, 199)
            case 4:
                XCTAssertNotNil(tuple.element.image)
                XCTAssertEqual(tuple.element.name, "pear")
                XCTAssertEqual(tuple.element.weight, 100)
                XCTAssertEqual(tuple.element.type, .pear)
                XCTAssertEqual(tuple.element.price, 99)
            case 5:
                XCTAssertNotNil(tuple.element.image)
                XCTAssertEqual(tuple.element.name, "strawberry")
                XCTAssertEqual(tuple.element.weight, 20)
                XCTAssertEqual(tuple.element.type, .strawberry)
                XCTAssertEqual(tuple.element.price, 99)
            case 6:
                XCTAssertNotNil(tuple.element.image)
                XCTAssertEqual(tuple.element.name, "kumquat")
                XCTAssertEqual(tuple.element.weight, 80)
                XCTAssertEqual(tuple.element.type, .kumquat)
                XCTAssertEqual(tuple.element.price, 49)
            case 7:
                XCTAssertNotNil(tuple.element.image)
                XCTAssertEqual(tuple.element.name, "pitaya")
                XCTAssertEqual(tuple.element.weight, 100)
                XCTAssertEqual(tuple.element.type, .pitaya)
                XCTAssertEqual(tuple.element.price, 599)
            case 8:
                XCTAssertNotNil(tuple.element.image)
                XCTAssertEqual(tuple.element.name, "kiwi")
                XCTAssertEqual(tuple.element.weight, 200)
                XCTAssertEqual(tuple.element.type, .kiwi)
                XCTAssertEqual(tuple.element.price, 89)
            case 9:
                XCTAssertNil(tuple.element.image)
                XCTAssertEqual(tuple.element.name, "newFruit")
                XCTAssertEqual(tuple.element.weight, 700)
                XCTAssertEqual(tuple.element.type, .unknown)
                XCTAssertEqual(tuple.element.price, 76)
            case _:
                XCTFail()
            }
        }
        
    }
    
}
