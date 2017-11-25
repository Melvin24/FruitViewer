//
//  Interactor.swift
//  FruitViewer

import Foundation

/// A protocol to represent an Interactor.
protocol Interactor: class {
    
    associatedtype T
    
    /// Current Task.
    var task: Task? { get set }
    
    func fetchData(completion: @escaping (Result<T>) -> Void)
    
    /// Call this method to invalid a fetch.
    func invalidateFetch()
    
}

extension Interactor {
    
    /// Call this method to invalid a fetch.
    func invalidateFetch() {
        task?.cancel()
    }
    
}
