//
//  PhotoViewerPresenter+Helper.swift
//  FruitViewer
//
//  Created by John, Melvin (Associate Software Developer) on 17/10/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

import UIKit

extension PhotoViewerPresenter {
    
//    /// Call this method to obtain a Detailed Photo viewer for a given image.
//    ///
//    /// - Parameter image: Image to show.
//    /// - Returns: DetailedPhotoViewerViewController.
//    func detailedPhotoViewerViewController(with image: UIImage) -> UIViewController? {
//
//        let coordinator = DetailedPhotoViewerNavigationCoordinator()
//
//        let destination = UIStoryboard.instantiateViewControllerFromStoryboardWithName(DetailedPhotoViewerViewController.Storyboard.name)
//
//        try? coordinator.prepareForNavigation(source: self.viewController, destination: destination, userInfo: image)
//
//        return destination
//    }
//
//    /// Call this method to obtain a loading view.
//    ///
//    /// - Returns: Loading View.
//    func loadingView() -> UIView {
//        return UIView.loadViewFromNib(as: LoadingView.self)
//    }
//
//    /// Call this method to obtain a No Data Error View.
//    ///
//    /// - Returns: An Error View with appropriate label text.
//    func noDataView() -> UIView {
//        let errorView = errorStatusView()
//        errorView.label.text = Strings.noPhotosFound
//        errorView.onRetryButtonSelect = self.viewController?.reloadPhotos
//
//        return errorView
//    }
//
//    /// Call this method to obtain an Error view for a given Error.
//    ///
//    /// - Parameter error: Error to use, to construct Error View.
//    /// - Returns: Error View with appropriate label text.
//    func errorView(forError error: Error) -> UIView {
//
//        let errorView = errorStatusView()
//
//        let errorLabel: String
//
//        switch error {
//        case let error as FlickrPhotoNetworking.FlickrPhotoNetworkingError:
//            errorLabel = errorString(for: error)
//        case let error as FlickrPhotoObjectMapper.FlickrPhotoObjectMapperError:
//            errorLabel = errorString(for: error)
//        case let error as FlickrPhotoObjectMapper.FlickrAPIErrorCode:
//            errorLabel = errorString(for: error)
//        default:
//            errorLabel = Strings.unexpectedError
//        }
//
//        errorView.label.text = errorLabel
//
//        errorView.onRetryButtonSelect = self.viewController?.reloadPhotos
//
//        return errorView
//
//    }
//
//    private func errorString(for error: FlickrPhotoObjectMapper.FlickrAPIErrorCode) -> String {
//
//        switch error {
//        case .apiUnavailable, .serviceUnavailable, .unknown:
//            return Strings.flickrAPIUnavailable
//        case .invalidAPIKey:
//            return Strings.flickrAPIKeyInvalid
//        case .badURL:
//            return Strings.flickrAPIBadRequest
//        }
//        
//    }
//
//    private func errorString(for error: FlickrPhotoObjectMapper.FlickrPhotoObjectMapperError) -> String {
//
//        switch error {
//        case .unwrapError(_):
//            return Strings.flickrAPIBadResponse
//        case .flickrAPIError(let apiError):
//            return errorString(for: apiError)
//        }
//
//    }
//
//    private func errorString(for error: FlickrPhotoNetworking.FlickrPhotoNetworkingError) -> String {
//        switch error {
//        case .unableToBuildURL:
//            return Strings.appCannotMakeRequest
//        case .noData, .unableToParseData:
//            return Strings.flickrAPIBadResponse
//        case .noConnection:
//            return Strings.noNetworkConnection
//        }
//    }
//
//    private func errorStatusView() -> ErrorView {
//        return UIView.loadViewFromNib(as: ErrorView.self)
//    }
    
}
