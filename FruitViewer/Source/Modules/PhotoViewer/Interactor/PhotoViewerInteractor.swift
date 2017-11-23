//
//  PhotoViewerInteractor.swift
//  FruitViewer

import Foundation

class PhotoViewerInteractor: Interactor {
    
    /// Current Task.
    var task: Task?
    
    /// Request type
    typealias RequestType = ((String) -> FruitDataNetworking.Request)
    
    /// Request to use when fetching data.
    let request: RequestType
    
    /// Initialize PhotoViewerInteractor with a request.
    ///
    /// - Parameter request: Request to use when fetching data
    init(withRequest request: @escaping RequestType) {
        self.request = request
    }
    
    /// Call this method to fetch data for a given argument and completion.
    ///
    /// - Parameters:
    ///   - argument: Argument, this can be the search string.
    ///   - completion: Completion block.
    func fetchData(withArgument argument: String, completion: @escaping (Error?) -> Void) {
        
        guard task == nil || task?.isRunning == false else {
            return
        }
        
        do {
            
            guard !argument.trimmingCharacters(in: .whitespaces).isEmpty else {
                completion(nil)
                return
            }
            
            let flickrPhotoRequest = request(argument)
            
            task = try flickrPhotoRequest { flickrPhotoCollection, error in
                completion(error)
            }
            
            task?.resume() // Resume task
            
        } catch let error {
            completion(error)
        }
        
    }
    
}
