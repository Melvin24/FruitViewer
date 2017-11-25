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
}
