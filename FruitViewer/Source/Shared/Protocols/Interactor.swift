//
//  Interactor.swift
//  FruitViewer

import Foundation

/// A protocol to represent an Interactor.
protocol Interactor: class {
    
    associatedtype Object
//
//    associatedtype Argument
    
    typealias Completion = (Object?, Error?) -> Void
    
    /// Current Task.
    var task: Task? { get set }
    
    /// Call this method to fetch data for a given argument and completion.
    ///
    /// - Parameters:
    ///   - argument: Argument, this can be the search string.
    ///   - completion: Completion block.
//    func fetchData(withArgument argument: Argument, completion: @escaping Completion)
    
    /// Call this method to invalid a fetch.
    func invalidateFetch()
    
}

extension Interactor {
    
    /// Call this method to invalid a fetch.
    func invalidateFetch() {
        task?.cancel()
    }
    
}
