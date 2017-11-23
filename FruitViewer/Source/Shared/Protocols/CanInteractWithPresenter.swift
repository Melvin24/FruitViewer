//
//  CanInteractWithPresenter.swift
//  FruitViewer

import Foundation

/// An interface which defines the basic setup of the viewController.
protocol CanInteractWithPresenter: class {
    
    associatedtype PresenterType: Presenter
    
    /// Associated presenter.
    var presenter: PresenterType! { get }
    
}
