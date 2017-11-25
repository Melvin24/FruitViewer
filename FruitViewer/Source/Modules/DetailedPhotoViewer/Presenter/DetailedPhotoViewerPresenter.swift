//
//  DetailedPhotoViewerPresenter.swift
//  FruitViewer

import UIKit

class DetailedPhotoViewerPresenter: Presenter {
    
    /// Associated view controller
    weak var viewController: DetailedPhotoViewerViewController?
    
    /// Image to display
    var image: UIImage
    
    func loadIfRequired() {
    }
    
    /// Init with an image to display.
    ///
    /// - Parameter image: Image to display.
    init(withImage image: UIImage) {
        self.image = image
    }
    
}
