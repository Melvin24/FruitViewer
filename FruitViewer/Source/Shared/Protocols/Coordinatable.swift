//
//  Coordinatable.swift
//  FruitViewer

import Foundation

/// Errors produced from coordinating
enum CoordinateError: Error {
    
    /// - unsupported: The coordination was not supported.
    case unsupported(String)
    
}

/// Identifies something capable of preparing navigation i.e Dependency Injection.
protocol Coordinatable {
    
    /// Prepare the destination for navigation.
    ///
    /// - parameter source:      The source object.
    /// - parameter destination: The destination object.
    /// - parameter userInfo:    Additional info for preparing for navigation.
    ///
    /// - throws: If the coordination fails.
    func prepareForNavigation<From, To>(source: From, destination: To, userInfo: Any?) throws
    
}
