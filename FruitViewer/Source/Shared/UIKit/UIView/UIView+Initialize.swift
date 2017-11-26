//
//  UIView+Initialize.swift
//  FruitViewer

import UIKit

extension UIView {
    
    /// Loads and returns a view from a nib file.
    ///
    /// - parameter type:   The class of the view nib to load.
    /// - parameter name:   The name of the view nib to load, defaults to the class name.
    /// - parameter bundle: The bundle to load the nib from, defaults to the main bundle.
    ///
    /// - returns: A view loaded from the nib in `bundle`.
    static func loadViewFromNib<T: UIView>(as type: T.Type, name: String = classNameFromType(T.self), bundle: Bundle = .main) -> T {
        return bundle.loadNibNamed(name, owner: nil, options: nil)?.first as! T
    }
}
