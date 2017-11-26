//
//  Reuseable.swift
//  FruitViewer

import Foundation

/// A reuse protocol for objects that can be reused and that require an identifier.
protocol Reuseable: class {
    
    /// The default reuse identifier for cells
    static var defaultReuseIdentifier: String { get }
    
}
