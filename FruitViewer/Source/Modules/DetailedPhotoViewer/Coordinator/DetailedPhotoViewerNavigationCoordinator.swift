//
//  DetailedPhotoViewerNavigationCoordinator.swift
//  FruitViewer

import UIKit

class DetailedPhotoViewerNavigationCoordinator: Coordinatable {
    
    func prepareForNavigation<From, To>(source: From, destination: To, userInfo: Any?) throws {
        
        guard source is PhotoViewerViewController,
              let destination = destination as? DetailedPhotoViewerViewController else {
            throw CoordinateError.unsupported("Coordination isnt supported")
        }
        
        guard let flickrPhoto = userInfo as? UIImage else {
            throw CoordinateError.unsupported("Coordinationexpected a UIImage as user info")
        }
        
        let presenter = DetailedPhotoViewerPresenter(withImage: flickrPhoto)
        
        presenter.viewController = destination
        
        destination.presenter = presenter
        
    }
}
