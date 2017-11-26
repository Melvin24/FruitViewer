//
//  Functions.swift
//  FruitViewer

import Foundation

/// Returns class name as String .
///
/// For loading xibs it's useful to reference the xib name which is
/// based off of a class name.
///
/// - parameter type: The type who's name we want to retrieve
///
/// - returns: A Class Name
func classNameFromType(_ type: AnyObject.Type) -> String {
    let components = NSStringFromClass(type).components(separatedBy: ".")
    
    if components.count == 2 {
        return components[1]
    } else {
        return components[0]
    }
}
