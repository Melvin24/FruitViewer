//
//  NetworkServiceError.swift
//  FruitViewer

import Foundation

enum NetworkServiceError: Error {

    case noConnection
    
    case couldNotBuildURL(URLPath: String)
    
    case HTTPError(type: HTTPURLResponse.ResponseType)
    
}
