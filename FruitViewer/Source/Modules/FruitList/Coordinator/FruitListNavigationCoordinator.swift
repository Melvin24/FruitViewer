//
//  FruitListNavigationCoordinator.swift
//  FruitViewer

import Foundation

class FruitListNavigationCoordinator: Coordinatable {
    
    lazy var networkService: FruitDataNetworkService = FruitDataNetworkService()
    
    func prepareForNavigation<From, To>(source: From, destination: To, userInfo: Any?) throws {
        
        guard let destination = destination as? FruitListViewController else {
            throw CoordinateError.unsupported("Coordination isnt supported")
        }
        
        let interactorRequest: FruitListInteractor.RequestType = networkService.fetchFruitData(session: .shared)
        
        let interactor = FruitListInteractor(withRequest: interactorRequest)
        
        let presenter = FruitListPresenter(viewController: destination, interactor: interactor)
        
        destination.presenter = presenter
    }
}
