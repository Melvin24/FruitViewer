//
//  UICollectionReusableView+ReuseIdentifier.swift
//  FruitViewer

import UIKit

extension UICollectionReusableView: Reuseable {
    
    /// The default reuse identifier for cells
    static var defaultReuseIdentifier: String {
        return "\(classNameFromType(self))Identifier"
    }
    
}
