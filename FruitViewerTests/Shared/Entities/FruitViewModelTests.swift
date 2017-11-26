//
//  FruitViewModelTests.swift
//  FruitViewerTests
//
//  Created by John, Melvin (Associate Software Developer) on 26/11/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

import XCTest
@testable import FruitViewer

class FruitViewModelTests: XCTestCase {
    
    func testFruitViewModelWithInvalidWeightAndPrice() {
        
        let fruit = Fruit(price: -123, type: .apple, weight: -123, image: nil, name: "apple")
        
        let viewModel = FruitViewModel(fruit: fruit)
        
        XCTAssertEqual(viewModel.fruitName, "Apple")
        XCTAssertEqual(viewModel.fruitPrice, Strings.fruitPriceInvalid)
        XCTAssertEqual(viewModel.fruitWeight, Strings.fruitWeightInvalid)
        XCTAssertNil(viewModel.fruitImage)

        
    }
    
    func testFruitViewModel() {
        
        let fruit = Fruit(price: 123, type: .apple, weight: 123, image: nil, name: "apple")
        
        let viewModel = FruitViewModel(fruit: fruit)
        
        XCTAssertEqual(viewModel.fruitName, "Apple")
        XCTAssertEqual(viewModel.fruitPrice, Strings.fruitPriceTitle(price: "1.23"))
        XCTAssertEqual(viewModel.fruitWeight, Strings.fruitWeightTitle(weight: "0.12"))
        XCTAssertNil(viewModel.fruitImage)
        
        
    }
    
}
