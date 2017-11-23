//
//  PhotoViewerViewController+PresenterDelegate.swift
//  FruitViewer

import UIKit

extension PhotoViewerViewController: PresenterDelegate {
    
    func presenterWillUpdateContent() {
        if !refreshControl.isRefreshing {
            DispatchQueue.main.async { [weak self] in
                self?.changeStatusView(with: self?.presenter.loadingView())
            }
        }
    }
    
    func presenterDidUpdateContent() {
        
        var statusView: UIView?
        if presenter.flickrPhotos.count == 0, !refreshControl.isRefreshing {
            statusView = presenter.noDataView()
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.reloadCollectionView() { [weak self] _ in
                self?.refreshControl.endRefreshing()
                self?.changeStatusView(with: statusView)
            }
        }
    }
    
    func presenterDidFail(withError error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.changeStatusView(with: self?.presenter.errorView(forError: error))
        }
    }
    
}
