//
//  FruitListPresenter+Helper.swift
//  FruitViewer

import UIKit

extension FruitListPresenter {
    
    // NOTE: Could potentially have a factory to setup view controllers
    /// Call this method to obtain a Detailed viewer for a given FruitViewModel Object.
    ///
    /// - Parameter FruitViewModel: FruitViewModel Object to use.
    /// - Returns: DetailedViewerViewController.
    func detailedPhotoViewerViewController(with fruitViewModel: FruitViewModel, shouldHideDetails: Bool = false) -> DetailedViewerViewController? {

        let coordinator: Coordinatable = DetailedViewerNavigationCoordinator()

        let destination = UIStoryboard.instantiateViewControllerFromStoryboard(withName: DetailedViewerViewController.Storyboard.name) as? DetailedViewerViewController

        let userInfo = (fruitViewModel: fruitViewModel, shouldHideDetails: shouldHideDetails)
        
        try? coordinator.prepareForNavigation(source: self.viewController,
                                         destination: destination,
                                            userInfo: userInfo)

        return destination
    }

    /// Call this method to obtain a loading view.
    ///
    /// - Returns: Loading View.
    func loadingView() -> UIView {
        return UIView.loadViewFromNib(as: LoadingView.self)
    }

    /// Call this method to obtain a No Data Error View.
    ///
    /// - Returns: An Error View with appropriate label text.
    func noDataView() -> UIView {
        let errorView = errorStatusView()
        errorView.label.text = Strings.noFruitsToShow
        errorView.onRetryButtonSelect = self.viewController?.reloadFruitList

        return errorView
    }

    /// Call this method to obtain an Error view for a given Error.
    ///
    /// - Parameter error: Error to use, to construct Error View.
    /// - Returns: Error View with appropriate label text.
    func errorView(forError error: Error) -> UIView {

        let errorView = errorStatusView()
        
        errorView.onRetryButtonSelect = self.viewController?.reloadFruitList
        
        let errorLabel: String

        if let fruitDataNetworkError = error as? FruitDataNetworkService.FruitDataNetworkingError {
            errorLabel = errorMessage(forError: fruitDataNetworkError)
        } else if let networkError = error as? NetworkServiceError {
            errorLabel = errorMessage(forError: networkError)
        } else {
            errorLabel = Strings.unexpectedError
        }

        errorView.label.text = errorLabel

        return errorView

    }
    
    func errorMessage(forError error: FruitDataNetworkService.FruitDataNetworkingError) -> String {
        
        switch error {
        case .noData:
            return Strings.noDataFromAPI
        case .unableToParseData:
            return Strings.badResponseFromAPI
        }
    }
    
    func errorMessage(forError error: NetworkServiceError) -> String {
        
        switch error {
        case .noConnection:
            return Strings.noNetworkConnection
        case .couldNotBuildURL, .HTTPError:
            return Strings.unexpectedError

        }
    }

    private func errorStatusView() -> ErrorView {
        return UIView.loadViewFromNib(as: ErrorView.self)
    }
    
}
