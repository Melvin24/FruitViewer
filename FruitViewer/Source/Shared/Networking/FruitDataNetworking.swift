//
//  FruitDataNetworking.swift
//  FruitViewer

import Foundation

class FruitDataNetworking {
    
    /// Network Error
    enum FruitDataNetworkingError: Error {
        
        /// Unable to buld URL Error
        case unableToBuildURL
        
        /// No Data from Fruit Data API.
        case noData
        
        /// Failed to Parse Fruit API Response.
        case unableToParseData
        
        /// No Network Connection.
        case noConnection
    }
        
    public typealias Completion = (Result<[Fruit]>) -> Void
    
    public typealias Request = (@escaping Completion) throws -> Task
    
    /// Call this method to obtain a request to fetch flickr photos. 
    func fetchFruitData(session: URLSession) -> Request {
        
        return { [weak self] completion in
            
            guard let strongSelf = self,
                  let fruitAPIURL = strongSelf.fruitDataAPIURL() else {
                    throw FruitDataNetworkingError.unableToBuildURL
            }
            
            return session.dataTask(with: fruitAPIURL) { data, response, error in
                
                guard error?._code != NSURLErrorTimedOut && error?._code != NSURLErrorNotConnectedToInternet else {
                    completion(.failure(FruitDataNetworkingError.noConnection))
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
    
    var fruitDataAPIURL: (() -> URL?) = {
        let URLPath = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json"
        return URL(string: URLPath)
    }
}
