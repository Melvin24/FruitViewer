//
//  PhotoViewerViewController+ UIViewControllerPreviewDelegate.swift
//  FruitViewer

import UIKit

/// Implementation for 3D Touch.
extension PhotoViewerViewController: UIViewControllerPreviewingDelegate {
    
    @available(iOS 9.0, *)
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        presentViewController(viewControllerToCommit)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let collectionViewLocation = collectionView.convert(location, from: view)
        
        guard let indexPath = collectionView.indexPathForItem(at: collectionViewLocation),
              let cell = collectionView?.cellForItem(at: indexPath) else {
            return nil
        }
        
        let flickrPhotos = presenter.flickrPhotos

        guard indexPath.row < flickrPhotos.count else {
            return nil
        }

        guard let image = flickrPhotos[indexPath.row].image else {
            return nil
        }
        
        guard let detailedPhotoViewController = presenter.detailedPhotoViewerViewController(with: image) else {
            return nil
        }

        detailedPhotoViewController.preferredContentSize = CGSize(width: 0.0, height: 300)
        
        previewingContext.sourceRect = cell.frame
        
        return detailedPhotoViewController
        
    }
    
}
