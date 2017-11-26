//
//  UICollectionView+Register.swift
//  FruitViewer

import UIKit

extension UICollectionView {
    
    /// Convenience function to register cells from nib.
    ///
    /// - parameter nib:    The class type to register. e.g. `MyCellClass.self`
    /// - parameter bundle: Main Bundle.
    func register(nib: Reuseable.Type, bundle: Bundle? = nil) {
        register(UINib(nibName: classNameFromType(nib), bundle: bundle), forCellWithReuseIdentifier: nib.defaultReuseIdentifier)
    }
    
    /// Convenience function to obtain dequeued cell using the defaultReuseIdentifier available on `UICollectionReusableView`.
    ///
    /// - parameter type:      The class type, must be a subclass of `UICollectionViewCell`
    /// - parameter indexPath: the currrent indexPath to query the collection view cache
    ///
    /// - returns: A dequeued cell.
    func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.defaultReuseIdentifier, for: indexPath) as! T
    }
    
}
