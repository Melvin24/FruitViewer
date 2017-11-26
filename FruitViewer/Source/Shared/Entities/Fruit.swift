//
//  Fruit.swift
//  FruitViewer

import UIKit

/// A Struct to represent Fruit API
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
/// A struct to represent Fruit.
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
    
    let image: UIImage?
    
    let name: String
    
    init(price: Double, type: Kind, weight: Double, image: UIImage?, name: String) {
        self.price = price
        self.type = type
        self.weight = weight
        self.image = image
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: FruitCodingKey.self)
        
        price = try container.decode(Double.self, forKey: .price)
        type = try container.decode(Kind.self, forKey: .type)
        weight = try container.decode(Double.self, forKey: .weight)
        image = Fruit.image(forFruitKind: type)
        name = try container.decode(String.self, forKey: .type)
    }
    
    private static func image(forFruitKind kind: Kind) -> UIImage? {
        switch kind {
        case .apple:
            return UIImage(named: "apple_image")
        case .banana:
            return UIImage(named: "banana_image")
        case .blueberry:
            return UIImage(named: "blueberries_image")
        case .kiwi:
            return UIImage(named: "kiwi_image")
        case .kumquat:
            return UIImage(named: "kumquat_image")
        case .orange:
            return UIImage(named: "orange_image")
        case .pear:
            return UIImage(named: "pear_image")
        case .pitaya:
            return UIImage(named: "pitaya_image")
        case .strawberry:
            return UIImage(named: "strawberry_image")
        case .unknown:
            return nil
        }
    }
    
}
