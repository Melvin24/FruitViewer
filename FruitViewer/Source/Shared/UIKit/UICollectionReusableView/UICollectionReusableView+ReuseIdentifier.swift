//
//  UICollectionReusableView+ReuseIdentifier.swift
//  FruitViewer

import UIKit

extension UICollectionReusableView: Reuseable {
    
    public static var defaultReuseIdentifier: String {
        return "\(classNameFromType(self))Identifier"
    }
    
}
