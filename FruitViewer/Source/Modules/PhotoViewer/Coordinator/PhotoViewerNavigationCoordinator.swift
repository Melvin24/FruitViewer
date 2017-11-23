//
//  PhotoViewerNavigationCoordinator.swift
//  FruitViewer

import Foundation

class PhotoViewerNavigationCoordinator: Coordinatable {
    
    func prepareForNavigation<From, To>(source: From, destination: To, userInfo: Any?) throws {
        
        guard let destination = destination as? PhotoViewerViewController else {
            throw CoordinateError.unsupported("Coordination isnt supported")
        }
        
        let interactorRequest: PhotoViewerInteractor.RequestType = { searchTerm in
            return FlickrPhotoNetworking.fetchFlickrPhotos(forSearchTerm: searchTerm, session: .shared)
        }
        
        let interactor = PhotoViewerInteractor(withRequest: interactorRequest)
        
        let presenter = PhotoViewerPresenter(viewController: destination, interactor: interactor)
        
        destination.presenter = presenter
    }
}
