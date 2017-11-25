//
//  NetworkServiceError.swift
//  FruitViewer
//
//  Created by John, Melvin (Associate Software Developer) on 25/11/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

import Foundation

enum NetworkServiceError: Error {

    case noConnection
    
    case couldNotBuildURL(URLPath: String)
    
    case HTTPError(type: HTTPURLResponse.ResponseType)
    
}
