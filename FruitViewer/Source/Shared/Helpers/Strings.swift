//
//  Strings.swift
//  FruitViewer

import Foundation

/// Struct to represent localized strings. 
struct Strings {
    
    static var localizedString = {
        return NSLocalizedString($0, comment: $1)
    }
    
    static var fruitListTitle: String {
        return localizedString("fruit-list.title", "Fruit List View Controller Title")
    }
    
    static var badResponseFromAPI: String {
        return localizedString("fruit-list-api-bad-response.reason", "API bad response")
    }
    
    static var noDataFromAPI: String {
        return localizedString("fruit-list-api-no-response.reason", "API did not return any data")
    }
    
    static var unexpectedError: String {
        return localizedString("unexpected-error.reason", "Unexpected Error")
    }
    
    static var noNetworkConnection: String {
        return localizedString("no-network-connection.reason", "No network connection.")
    }
    
    static var noFruitsToShow: String {
        return localizedString("no-fruits-to-show.reason", "No Fruits To Show.")
    }
    
    static func fruitPriceTitle(price: String) -> String {
        let translation = localizedString("fruit-price.title", "Fruit Price Title.")
        
        return translation.replacingOccurrences(of: "{{price}}", with: price)
    }
    
    static var fruitPriceInvalid: String {
        return localizedString("fruit-price_invalid.title", "Fruit Price Invalid Title.")
    }
    
    static func fruitWeightTitle(weight: String) -> String {
        let translation = localizedString("fruit-weight.title", "Fruit Weight Title.")
        
        return translation.replacingOccurrences(of: "{{weight}}", with: weight)
    }
    
    static var fruitWeightInvalid: String {
        return localizedString("fruit-weight_invalid.title", "Fruit Weight Invalid Title.")
    }
}
