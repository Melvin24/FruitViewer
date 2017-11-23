//
//  PhotoViewerViewController.swift
//  FruitViewer

import UIKit

class PhotoViewerViewController: UIViewController, CanInteractWithPresenter, CanShowStatusView {

    /// Collection View
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// Search text field.
    @IBOutlet weak var searchTextField: UITextField!
    
    /// Collection view container view.
    @IBOutlet weak var collectionViewContainerView: UIView!
    
    weak var statusView: UIView?
    
    weak var statusContainerView: UIView?
    
    /// Associated presenter.
    var presenter: PhotoViewerPresenter!
    
    /// The control which manages the pull to refresh functionality.
    lazy var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefreshController(forCollectionView: collectionView)
                
        searchTextField.placeholder = Strings.searchBarPlaceholderName
        
        statusContainerView = collectionViewContainerView
        
        collectionView.register(nib: PhotoViewerCell.self)

    }
    
    /// Responsible for reloading current Flickr data.
    func reloadPhotos() {
        presenter.fetchPhotos(forSearchTerm: presenter.currentSearchTerm)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(for: searchTextField)
    }
    
    /// Causes a given text field to resign the first responder status.
    ///
    /// - Parameter textField: Text Field to resign the first responder.
    func endEditing(for textField: UITextField) {
        textField.endEditing(true)
    }
    
    func setupRefreshController(forCollectionView collectionView: UICollectionView) {
        
        refreshControl.addTarget(self, action: #selector(reloadPhotos), for: .valueChanged)

        collectionView.alwaysBounceVertical = true
        
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.insertSubview(refreshControl, at: 0)
        }
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        switch traitCollection.forceTouchCapability {
        case .available:
            registerForPreviewing(with: self, sourceView: view)
        default:
            return
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        /// On Transition animation finish invalidate collection view layout, to refresh layout.
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            
            guard let collectionView = self?.collectionView else {
                return
            }
            
            self?.invalidateCollectionViewLayout(collectionView)
        }
    }

    func invalidateCollectionViewLayout(_ collectionView: UICollectionView) {
        collectionView.collectionViewLayout.invalidateLayout()
    }

    /// Responsible for reloading collection view by performing batch update. 
    func reloadCollectionView(_ completion: @escaping ((Bool) -> Void)) {
        collectionView.performBatchUpdates({ [weak self] in
            self?.collectionView.reloadSections(IndexSet(integer: 0))
        }, completion: completion)
    }
    
    func presentViewController(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}

extension PhotoViewerViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let searchTerm = textField.text,
            !searchTerm.isEmpty else {
                return true
        }
        
        self.presenter.fetchPhotos(forSearchTerm: searchTerm)
        endEditing(for: textField)
        return true
    }
    
}
