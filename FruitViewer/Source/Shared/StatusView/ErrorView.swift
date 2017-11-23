//
//  ErrorView.swift
//  FruitViewer

import UIKit

class ErrorView: UIView {
    
    /// Error View Label.
    @IBOutlet weak var label: UILabel!
    
    /// Set this block to support retry logic. Called on Retry Button select.
    var onRetryButtonSelect: (() -> Void)?
    
    @IBAction func didSelectRetryButton(_ sender: UIButton) {
        onRetryButtonSelect?()
    }
}
