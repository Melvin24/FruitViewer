//
//  FruitListViewController+ UIViewControllerPreviewDelegate.swift
//  FruitViewer

import UIKit

/// Implementation for 3D Touch.
extension FruitListViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        guard let navigationController = navigationController,
              let detailedViewerViewController = viewControllerToCommit as? DetailedViewerViewController else {
            return
        }
        
        detailedViewerViewController.toggleinformationContainerView(false)
        
        pushViewControllerToNavigationController(navigationController)(viewControllerToCommit, true)

    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        // Obtain user initiated display time
        let userInitiatedDate = Date()

        let collectionViewLocation = collectionView.convert(location, from: view)
        
        guard let indexPath = collectionView.indexPathForItem(at: collectionViewLocation),
              let cell = collectionView?.cellForItem(at: indexPath) else {
            return nil
        }
        
        let fruitViewModels = presenter.fruitViewModels

        guard indexPath.row < fruitViewModels.count else {
            return nil
        }

        guard let detailedViewerViewController = presenter.detailedPhotoViewerViewController(with: fruitViewModels[indexPath.row], shouldHideDetails: true) else {
            return nil
        }

        // set to viewcontroller for obtain display render duration.
        detailedViewerViewController.userInitiatedDate = userInitiatedDate

        detailedViewerViewController.preferredContentSize = CGSize(width: 0.0, height: 300)
        
        previewingContext.sourceRect = cell.frame
        
        return detailedViewerViewController
        
    }
    
}
