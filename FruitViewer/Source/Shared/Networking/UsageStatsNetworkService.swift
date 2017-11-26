//
//  UsageStatsNetworkService.swift
//  FruitViewer
//
//  Created by John, Melvin (Associate Software Developer) on 25/11/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

import Foundation

class UsageStatsNetworkService {
    
    typealias Completion = (Bool, NetworkServiceError?) -> Void
    
    typealias Request = (@escaping Completion) throws -> Task
    
    /// Call this method to obtain a request to fetch fruit data.
    func updateUsageStats(withURLPath URLPath: String, session: URLSession) -> Request {
        
        return { completion in
            
            guard let usageStatsURL = URL(string: URLPath) else {
                throw NetworkServiceError.couldNotBuildURL(URLPath: URLPath)
            }
            
            return session.dataTask(with: usageStatsURL) { data, response, error in
                
                guard error?._code != NSURLErrorTimedOut && error?._code != NSURLErrorNotConnectedToInternet else {
                    completion(false, .noConnection)
                    return
                }
                
                guard let httpURLResponse = response as? HTTPURLResponse else {
                    completion(true, nil)
                    return
                }

                let responseType = httpURLResponse.responseType
                
                switch responseType {
                case .success, .redirection:
                    completion(true, nil)
                default:
                    completion(false, .HTTPError(type: responseType))
                }
                
            }
        }
        
    }
    
}

