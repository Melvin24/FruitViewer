//
//  Strings.swift
//  FruitViewer

import Foundation

/// Struct to represent localized strings. 
struct Strings {
    
    static var localizedString = {
        return NSLocalizedString($0, comment: $1)
    }
    
    public static var badResponseFromAPI: String {
        return localizedString("fruit-list-api-bad-response.reason", "API bad response")
    }
    
    public static var noDataFromAPI: String {
        return localizedString("fruit-list-api-no-response.reason", "API did not return any data")
    }
    
    public static var unexpectedError: String {
        return localizedString("unexpected-error.reason", "Unexpected Error")
    }
    
    public static var noNetworkConnection: String {
        return localizedString("no-network-connection.reason", "No network connection.")
    }
    
    public static var noFruitsToShow: String {
        return localizedString("no-fruits-to-show.reason", "No Fruits To Show.")
    }
    
    public static func fruitPriceTitle(price: String) -> String {
        let translation = localizedString("fruit-price.title", "Fruit Price Title.")
        
        return translation.replacingOccurrences(of: "{{price}}", with: price)
    }
    
    public static var fruitPriceInvalid: String {
        return localizedString("fruit-price_invalid.title", "Fruit Price Invalid Title.")
    }
    
    public static func fruitWeightTitle(weight: String) -> String {
        let translation = localizedString("fruit-weight.title", "Fruit Weight Title.")
        
        return translation.replacingOccurrences(of: "{{weight}}", with: weight)
    }
    
    public static var fruitWeightInvalid: String {
        return localizedString("fruit-weight_invalid.title", "Fruit Weight Invalid Title.")
    }
}
