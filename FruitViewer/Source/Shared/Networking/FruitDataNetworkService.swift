//
//  FruitDataNetworkService.swift
//  FruitViewer

import Foundation

struct RequestURL {
    static let basePath: String = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master"
}

/// Responsible for performing Network request to fetch fruit data.
class FruitDataNetworkService {
    
    var URLPath = "\(RequestURL.basePath)/data.json"
    
    /// Network Error
    enum FruitDataNetworkingError: Error {
        
        /// No Data from Fruit Data API.
        case noData
        
        /// Failed to Parse Fruit API Response.
        case unableToParseData
        
    }
        
    typealias Completion = (Result<[Fruit]>) -> Void
    
    typealias Request = (@escaping Completion) throws -> Task
    
    /// Call this method to obtain a request to fetch fruit data.
    func fetchFruitData(session: URLSession) -> Request {
        
        return { completion in
            
            guard let fruitAPIURL = URL(string: self.URLPath) else {
                throw NetworkServiceError.couldNotBuildURL(URLPath: self.URLPath)
            }
            
            return session.dataTask(with: fruitAPIURL) { data, response, error in
                
                guard error?._code != NSURLErrorTimedOut && error?._code != NSURLErrorNotConnectedToInternet else {
                    completion(.failure(NetworkServiceError.noConnection))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(FruitDataNetworkingError.noData))
                    return
                }
                
                guard let fruitData = try? JSONDecoder().decode(FruitData.self, from: data) else {
                    completion(.failure(FruitDataNetworkingError.unableToParseData))
                    return
                }
                
                completion(.success(fruitData.fruits))
                
            }
        }
    }
}
