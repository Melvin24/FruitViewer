//
//  PhotoViewerPresenter.swift
//  FruitViewer

import UIKit

class PhotoViewerPresenter: Presenter {
    
    /// Associated view controller.
    weak var viewController: PhotoViewerViewController?
    
    /// Associated Interactor.
    var interactor: PhotoViewerInteractor
    
    /// Latest search term.
    var currentSearchTerm: String = ""
    
    init(viewController: PhotoViewerViewController, interactor: PhotoViewerInteractor) {
        self.viewController = viewController
        self.interactor = interactor
    }

    /// Call this method to fetch Photos for a given search term.
    ///
    /// - Parameter searchTerm: Search term.
    func fetchPhotos(forSearchTerm searchTerm: String) {

        currentSearchTerm = searchTerm
        
        self.viewController?.presenterWillUpdateContent()

        // Asking the interactor to fetch data for search term. 
        interactor.fetchData(withArgument: searchTerm) { [weak self] flickrPhotos, error in
            
            if let error = error {
                self?.viewController?.presenterDidFail(withError: error)
            } else {
                self?.flickrPhotos = flickrPhotos ?? []
                self?.viewController?.presenterDidUpdateContent()
            }
            
        }
    }
    
}
