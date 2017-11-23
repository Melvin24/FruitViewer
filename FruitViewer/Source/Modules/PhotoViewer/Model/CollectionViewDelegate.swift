//
//  CollectionViewDelegate.swift
//  FruitViewer

import UIKit

class CollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let lineSpacing: CGFloat = 4
    let interItemSpacing: CGFloat = 4
    let numberOfItemsPerRowPortrait: CGFloat = 3
    let numberOfItemsPerRowLandscape: CGFloat = 4
    let sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 4, right: 4)
    
    /// Current device, used to check for orientation.
    var device = UIDevice.current
    
    @IBOutlet weak var viewController: PhotoViewerViewController!
    
    /// Asks the delegate for the spacing between successive items in the rows or columns of a section.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    /// Asks the delegate for the spacing between successive rows or columns of a section.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    /// Asks the delegate for the margins to apply to content in the specified section.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxContentWidth = viewController.view.frame.width
        
        let availableContentWidth = maxContentWidth - (sectionInset.left + sectionInset.right + interItemSpacing)
        
        guard availableContentWidth > 0 else {
            return .zero
        }
        
        let itemsPerRow = device.orientation.isLandscape ? numberOfItemsPerRowLandscape : numberOfItemsPerRowPortrait
        
        let maxWidthAndHeightPerItem = availableContentWidth/itemsPerRow
        
        return CGSize(width: maxWidthAndHeightPerItem, height: maxWidthAndHeightPerItem)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let flickrPhotos = viewController.presenter.flickrPhotos
        
        guard indexPath.row < flickrPhotos.count else {
            return
        }
        
        guard let image = flickrPhotos[indexPath.row].image else {
            return
        }
        
        guard let detailedPhotoViewController = viewController.presenter.detailedPhotoViewerViewController(with: image) else {
            return
        }
        
        viewController.presentViewController(detailedPhotoViewController)
        
    }
    
}
