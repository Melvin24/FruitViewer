//
//  UsageStatsNetworkService.swift
//  FruitViewer

import Foundation

class UsageStatsNetworkService {
    
    typealias Completion = (Bool, NetworkServiceError?) -> Void
    
    typealias Request = (@escaping Completion) throws -> Task
    
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
