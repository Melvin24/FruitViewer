//
//  DetailedViewerPresenter.swift
//  FruitViewer

import UIKit

class DetailedViewerPresenter: Presenter {
    
    /// Associated view controller
    weak var viewController: DetailedViewerViewController?
    
    /// Image to display
    let fruitViewModel: FruitViewModel
    
    let shouldHideDetails: Bool
    
    func loadIfRequired() {
    }
    
    /// Init with Fruit object.
    ///
    /// - Parameter fruitViewModel: fruitViewModel Object.
    init(withFruitViewModel fruitViewModel: FruitViewModel, shouldHideDetails: Bool) {
        self.fruitViewModel = fruitViewModel
        self.shouldHideDetails = shouldHideDetails
    }
    
}
