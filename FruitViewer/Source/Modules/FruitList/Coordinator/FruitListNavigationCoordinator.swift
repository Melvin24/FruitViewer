//
//  FruitListNavigationCoordinator.swift
//  FruitViewer

import UIKit

/// FruitList navigation coordinator for dependency injection.
class FruitListNavigationCoordinator: Coordinatable {
    
    lazy var networkService = FruitDataNetworkService()
    
    /// Call this method before displaying FruitListViewController. 
    func prepareForNavigation<From, To>(source: From, destination: To, userInfo: Any?) throws {
        
        guard let navigationController = destination as? UINavigationController,
            let fruitListViewController = navigationController.topViewController as? FruitListViewController else {
            throw CoordinateError.unsupported("Coordination not supported")
        }
        
        let interactorRequest: FruitListInteractor.RequestType = networkService.fetchFruitData(session: .shared)
        
        let interactor = FruitListInteractor(withRequest: interactorRequest)
        
        let presenter = FruitListPresenter(viewController: fruitListViewController, interactor: interactor)
        
        fruitListViewController.presenter = presenter
    }
}
