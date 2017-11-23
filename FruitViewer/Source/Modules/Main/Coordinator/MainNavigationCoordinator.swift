//
//  MainNavigationCoordinator.swift
//  FruitViewer

import Foundation

class MainNavigationCoordinator: Coordinatable {
    
    func prepareForNavigation<From, To>(source: From, destination: To, userInfo: Any?) throws {
        
        guard let destination = destination as? MainViewController else {
            throw CoordinateError.unsupported("Coordination isnt supported")
        }
        
        let presenter = MainPresenter()
        
        presenter.viewController = destination
        
        destination.presenter = presenter
    }
}
