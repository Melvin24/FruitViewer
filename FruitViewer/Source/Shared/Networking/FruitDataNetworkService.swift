//
//  FruitDataNetworkService.swift
//  FruitViewer

import Foundation

class FruitDataNetworkService {
    
    /// Network Error
    enum FruitDataNetworkingError: Error {
        
        /// No Data from Fruit Data API.
        case noData
        
        /// Failed to Parse Fruit API Response.
        case unableToParseData
        
    }
        
    public typealias Completion = (Result<[Fruit]>) -> Void
    
    public typealias Request = (@escaping Completion) throws -> Task
    
    /// Call this method to obtain a request to fetch fruit data.
    func fetchFruitData(session: URLSession) -> Request {
        
        return { completion in
            
            let URLPath = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json"
            
            guard let fruitAPIURL = URL(string: URLPath) else {
                throw NetworkServiceError.couldNotBuildURL(URLPath: URLPath)
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
