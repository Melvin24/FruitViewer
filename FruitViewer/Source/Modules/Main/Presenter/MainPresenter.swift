//
//  MainPresenter.swift
//  FruitViewer

import UIKit

class MainPresenter: Presenter {
    
    weak var viewController: MainViewController?
    
    /// Call this method to navigate to Photo Viewer view controller
    func navigateToPhotoViewer() {
        
        guard let viewController = self.viewController else {
            return
        }
        
        viewController.performSegue(withIdentifier: MainViewController.Segue.mainToFruitList.rawValue, sender: viewController)
        
    }
    
    /// Call this method to load any required data.
    func loadIfRequired() {
    }
    
    /// Call this method to prepare a view controller for navigation
    ///
    /// - Parameter viewController: FruitListViewController
    func preparePhotoViewerViewController(_ viewController: UIViewController) {
        
        let navigationCoordinator = FruitListNavigationCoordinator()
        
        try? navigationCoordinator.prepareForNavigation(source: viewController, destination: viewController, userInfo: nil)
        
    }
}
