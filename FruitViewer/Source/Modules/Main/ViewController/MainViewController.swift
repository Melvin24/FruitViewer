//
//  MainViewController.swift
//  FruitViewer

import UIKit

class MainViewController: UIViewController, CanInteractWithPresenter {
    
    @IBOutlet weak var bbcLogo: UIImageView!
    
    var presenter: MainPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 2, animations: { [weak self] in
            self?.bbcLogo.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self?.bbcLogo.alpha = 0
        }, completion: { [weak self] _ in
            self?.presenter.navigateToPhotoViewer()
        })
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        presenter.preparePhotoViewerViewController(segue.destination)
    }
    
}

extension MainViewController {
    
    enum Storyboard: String {
        case name = "Main"
    }
    
    enum Segue: String {
        case mainToFruitList = "MainToFruitListViewController"
    }
}
