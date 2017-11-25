//
//  HTTPURLResponse+ResponseType.swift
//  FruitViewer

import Foundation

extension HTTPURLResponse {
    
    /// The response class representation of status codes.
    enum ResponseType: String {

        /// - success: This class of status codes indicates the action requested by the client was received, understood, accepted, and processed successfully.
        case success
        
        /// - redirection: This class of status code indicates the client must take additional action to complete the request.
        case redirection
        
        /// - clientError: This class of status code is intended for situations in which the client seems to have erred.
        case clientError
        
        /// - serverError: This class of status code indicates server error.
        case serverError
        
        /// - undefined: The class of the status code cannot be resolved.
        case undefined
        
    }
    
    var responseType: ResponseType {
        
        switch self.statusCode {
            
        case 100..<300:
            return .success
            
        case 300..<400:
            return .redirection
            
        case 400..<500:
            return .clientError
            
        case 500..<600:
            return .serverError
            
        default:
            return .undefined
            
        }
        
    }
}
