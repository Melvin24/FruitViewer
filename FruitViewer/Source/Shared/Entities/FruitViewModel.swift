//
//  FruitViewModel.swift
//  FruitViewer
//
//  Created by John, Melvin (Associate Software Developer) on 25/11/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

import UIKit

struct FruitViewModel {
    
    let fruitImage: UIImage?
    
    let fruitPrice: String
    
    let fruitWeight: String
    
    let fruitName: String
    
    init(fruit: Fruit) {
        
        fruitImage = fruit.image
        
        var weightInKG = fruit.weight/1000
        
        // Rounding to the nearest 2dp
        weightInKG = round(100*weightInKG)/100
        
        let priceInPound = fruit.price/100
        
        if weightInKG < 0 {
            fruitWeight = Strings.fruitWeightInvalid
        } else {
            fruitWeight = Strings.fruitWeightTitle(weight: (String(format: "%.2f", weightInKG)))
        }
        
        if priceInPound < 0 {
            fruitPrice = Strings.fruitPriceInvalid
        } else {
            fruitPrice = Strings.fruitPriceTitle(price: (String(format: "%.2f", priceInPound)))
        }
        
        let nameOfFruit = fruit.name.lowercased()
        
        fruitName = nameOfFruit.capitalized
        
    }
    
}
