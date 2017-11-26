//
//  FruitListViewController.swift
//  FruitViewer

import UIKit

class FruitListViewController: UIViewController, CanInteractWithPresenter, CanShowStatusView {

    /// Collection View
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// Collection view container view.
    @IBOutlet weak var collectionViewContainerView: UIView!
    
    weak var statusView: UIView?
    
    weak var statusContainerView: UIView?
    
    /// Associated presenter.
    var presenter: FruitListPresenter!
    
    /// The control which manages the pull to refresh functionality.
    lazy var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Strings.fruitListTitle
        
        setupRefreshController(forCollectionView: collectionView)
        
        statusContainerView = collectionViewContainerView
        
        collectionView.register(nib: FruitListCell.self)
        
        presenter.loadIfRequired()

    }
    
    /// Responsible for reloading current Fruit List.
    @objc
    func reloadFruitList() {
        presenter.loadIfRequired()
    }

    func setupRefreshController(forCollectionView collectionView: UICollectionView) {
        
        refreshControl.addTarget(self, action: #selector(reloadFruitList), for: .valueChanged)

        collectionView.alwaysBounceVertical = true
        
        collectionView.refreshControl = refreshControl

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
    
    /// Test Injection
    var pushViewControllerToNavigationController = UINavigationController.pushViewController

}
