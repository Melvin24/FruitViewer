//
//  Presenter.swift
//  FruitViewer

import UIKit

/// An interface which defines the basic setup of the presenter.
protocol Presenter: class {
    
    associatedtype viewController: UIViewController
    
    /// Associated view controller.
    weak var viewController: viewController? { get set }
    
    /// Call this method to load any required data.
    func loadIfRequired()
    
}
