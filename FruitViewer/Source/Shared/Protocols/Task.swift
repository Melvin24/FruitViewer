//
//  Task.swift
//  FruitViewer

import Foundation

/// A Task represents any syncronus or asyncronus object so we can cancel or resume.
protocol Task {
    
    /// Determines whether the task is running.
    var isRunning: Bool { get }
    
    /// Resume a currently suspended or non-started task.
    func resume()
    
    /// Cancels the task.
    func cancel()
    
}

extension URLSessionTask: Task {
    
    var isRunning: Bool {
        return state == .running
    }
    
}
