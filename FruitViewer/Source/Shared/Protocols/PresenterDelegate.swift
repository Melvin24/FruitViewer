//
//  PresenterDelegate.swift
//  FruitViewer

import Foundation

/// A protocol which view controllers can conform to, to identify presenter updates.
protocol PresenterDelegate: class {
    
    /// Delegate method sent when the presenter is about to start updating content.
    func presenterWillUpdateContent()
    
    /// Delegate method sent when the presenter has finished updating content.
    func presenterDidUpdateContent()
    
    /// Delegate method sent when the preseter failed with an error.
    func presenterDidFail(withError error: Error)
    
}

extension PresenterDelegate {
    
    func presenterWillUpdateContent() { }
    
    func presenterDidUpdateContent() { }
    
    func presenterDidFail(withError error: Error) { }
    
}
