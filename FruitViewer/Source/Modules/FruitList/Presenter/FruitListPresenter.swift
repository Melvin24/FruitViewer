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

        let fetchStart = Date()

        // Asking the interactor to fetch data for search term. 
        interactor.fetchData { [weak self] result in
            
            guard let strongSelf = self else {
                return
            }
            
            let fetchEnd = Date()
            
            strongSelf.notifyLoadUsageStatsForRequestTime(strongSelf, fetchStart, fetchEnd)
            
            switch result {
            case .success(let fruits):
                strongSelf.fruitViewModels = fruits.map {
                    return FruitViewModel(fruit: $0)
                }
                strongSelf.viewController?.presenterDidUpdateContent()
            case .failure(let error):
                strongSelf.viewController?.presenterDidFail(withError: error)
            }
        }

    }
    
    var notifyLoadUsageStatsForRequestTime: ((CanNotifyNetworkRequestDuration, Date, Date) -> Void) = { notifier, startDate, endDate in
        notifier.notifyNetworkRequestDuration(startDate: startDate, endDate: endDate)
    }
    
}

extension FruitListPresenter: CanNotifyNetworkRequestDuration {
}
