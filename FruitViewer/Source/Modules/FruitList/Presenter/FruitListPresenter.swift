//
//  FruitListPresenter.swift
//  FruitViewer

import UIKit

class FruitListPresenter: Presenter {
    
    /// Associated view controller.
    weak var viewController: FruitListViewController?
    
    /// Associated Interactor.
    var interactor: FruitListInteractor
    
    init(viewController: FruitListViewController, interactor: FruitListInteractor) {
        self.viewController = viewController
        self.interactor = interactor
    }
    
    var fruitViewModels: [FruitViewModel] = []

    /// Call this method to load any required data.
    func loadIfRequired() {
        
        self.viewController?.presenterWillUpdateContent()

        // Asking the interactor to fetch data for search term. 
        interactor.fetchData { [weak self] result in
            
            switch result {
            case .success(let fruits):
                self?.fruitViewModels = fruits.map {
                    return FruitViewModel(fruit: $0)
                }
                self?.viewController?.presenterDidUpdateContent()
            case .failure(let error):
                self?.viewController?.presenterDidFail(withError: error)
            }
        }

    }
    
}
