//
//  DetailedViewerNavigationCoordinator.swift
//  FruitViewer

import UIKit

class DetailedViewerNavigationCoordinator: Coordinatable {
    
    func prepareForNavigation<From, To>(source: From, destination: To, userInfo: Any?) throws {
        
        guard source is FruitListViewController,
              let destination = destination as? DetailedViewerViewController else {
            throw CoordinateError.unsupported("Coordination isnt supported")
        }
        
        guard let userInfo = userInfo as? (fruitViewModel: FruitViewModel, shouldHideDetails: Bool) else {
            throw CoordinateError.unsupported("Coordinationexpected a UIImage as user info")
        }
        
        let presenter = DetailedViewerPresenter(withFruitViewModel: userInfo.fruitViewModel,
                                                 shouldHideDetails: userInfo.shouldHideDetails)
        
        presenter.viewController = destination
        
        destination.presenter = presenter
        
    }
}
