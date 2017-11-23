//
//  LoadingView.swift
//  FruitViewer

import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activity.startAnimating()
    }
}
