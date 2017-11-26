//
//  UIStoryboard+Instantiate.swift
//  FruitViewer

import UIKit

extension UIStoryboard {
    
    /// Convenience function to initialise the initial view controller from a storyboard. Use type-safe enum identifiers instead of strings.
    ///
    /// - parameter name:   The enum of the storyboard view controller.
    /// - parameter bundle: Main Bundle.
    ///
    /// - returns: The initial view controller of storyboard or nil if it cannot be located.
    class func instantiateViewControllerFromStoryboard<T: RawRepresentable>(withName name: T, bundle: Bundle? = nil) -> UIViewController? where T.RawValue == String {
        return storyboardWithName(name, bundle: bundle).instantiateInitialViewController()
    }
    
    /// Convenience method to load a storyboard from a type-safe enum. This avoids spelling mistakes.
    ///
    /// - parameter name:   The enum of the storyboard name.
    /// - parameter bundle: Main Bundle.
    ///
    /// - returns: A new storyboard object, or nil if the method cannot find the specified storyboard file.
    class func storyboardWithName<T: RawRepresentable>(_ name: T, bundle: Bundle? = nil) -> UIStoryboard where T.RawValue == String {
        return UIStoryboard(name: name.rawValue, bundle: bundle)
    }
}
