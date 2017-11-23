//
//  Fruit.swift
//  FruitViewer

import UIKit

struct FruitData: Decodable {
    
    enum FruitDataCodingKey: CodingKey {
        case fruit
    }
    
    var fruits: [Fruit]
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: FruitDataCodingKey.self)
        
        fruits = try container.decode([Fruit].self, forKey: .fruit)
    }
    
}
/// A struct to represent fruit.
struct Fruit: Decodable {
    
    enum Kind: String, Decodable {
        case apple
        case banana
        case blueberry
        case orange
        case pear
        case strawberry
        case kumquat
        case pitaya
        case kiwi
        case unknown
        
        init(fromRawValue: String) {
            self = Kind(rawValue: fromRawValue) ?? .unknown
        }
        
        init(from decoder: Decoder) throws {
            
            let container = try decoder.singleValueContainer()
            
            let type = try? container.decode(String.self)
            
            self = .init(fromRawValue: type ?? "")
            
        }
    }
    
    enum FruitCodingKey: CodingKey {
        case price, type, weight
    }
    
    let price: Double
    
    let type: Kind
    
    let weight: Double
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: FruitCodingKey.self)
        
        price = try container.decode(Double.self, forKey: .price)
        type = try container.decode(Kind.self, forKey: .type)
        weight = try container.decode(Double.self, forKey: .weight)

        
    }
    
}
