//
//  NetworkServiceError.swift
//  FruitViewer

import Foundation

/// Common Network service error
enum NetworkServiceError: Error {

    /// No Connection Error
    case noConnection
    
    /// Unable to build a URL Type
    case couldNotBuildURL(URLPath: String)
    
    /// HTTP Error
    case HTTPError(type: HTTPURLResponse.ResponseType)
    
}
