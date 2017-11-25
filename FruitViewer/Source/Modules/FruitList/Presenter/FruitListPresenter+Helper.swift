//
//  FruitListPresenter+Helper.swift
//  FruitViewer

import UIKit

extension FruitListPresenter {
    
    /// Call this method to obtain a Detailed viewer for a given FruitViewModel Object.
    ///
    /// - Parameter FruitViewModel: FruitViewModel Object to use.
    /// - Returns: DetailedPhotoViewerViewController.
    func detailedPhotoViewerViewController(with fruitViewModel: FruitViewModel, shouldHideDetails: Bool = false) -> UIViewController? {

        let coordinator: Coordinatable = DetailedViewerNavigationCoordinator()

        let destination = UIStoryboard.instantiateViewControllerFromStoryboard(withName: DetailedViewerViewController.Storyboard.name)

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
        
        guard let fruitDataNetworkError = error as? FruitDataNetworkService.FruitDataNetworkingError else {
            errorView.label.text = Strings.unexpectedError
            return errorView
        }

        let errorLabel: String

        switch fruitDataNetworkError {
        case .noConnection:
            errorLabel = Strings.noNetworkConnection
        case .noData:
            errorLabel = Strings.noDataFromAPI
        case .unableToParseData:
            errorLabel = Strings.badResponseFromAPI
        case .unableToBuildURL:
            errorLabel = Strings.unexpectedError
        }

        errorView.label.text = errorLabel

        return errorView

    }

    private func errorStatusView() -> ErrorView {
        return UIView.loadViewFromNib(as: ErrorView.self)
    }
    
}
