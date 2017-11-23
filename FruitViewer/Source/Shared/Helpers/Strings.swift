//
//  Strings.swift
//  FruitViewer

import Foundation

/// Struct to represent localized strings. 
struct Strings {
    
    static var localizedString = {
        return NSLocalizedString($0, comment: $1)
    }
    
    public static var searchBarPlaceholderName: String {
        return localizedString("photo-viewer.search-bar.placeholder.text", "Search bar placeholder name")
    }
    
    public static var flickrAPIUnavailable: String {
        return localizedString("flickr-api-unavailable.reason", "Flicker api unavailable")
    }
    
    public static var flickrAPIKeyInvalid: String {
        return localizedString("flickr-api-key-invalid.reason", "Flicker api key invalid")
    }
    
    public static var flickrAPIBadRequest: String {
        return localizedString("flickr-api-bad-request.reason", " Flicker api bad request")
    }
    
    public static var flickrAPIBadResponse: String {
        return localizedString("flickr-api-bad-response.reason", "Flicker api bad response")
    }
    
    public static var appCannotMakeRequest: String {
        return localizedString("app-bad-flickr-api-request.reason", "App is having trouble building request for Flickr API.")
    }
    
    public static var unexpectedError: String {
        return localizedString("unexpected-error.reason", "Unexpected Error")
    }
    
    public static var noNetworkConnection: String {
        return localizedString("no-network-connection.reason", "No network connection.")
    }
    
    public static var noPhotosFound: String {
        return localizedString("no-flickr-photos.reason", "No Flickr Photos found.")
    }
}
