//
//  PostServices.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/16/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

struct PostServices{
    
    static let shared = PostServices()
    
    let parameters = [
        "sort_by": "votes_count",
        "order": "desc",
        "per_page": "20",
        "search[featured]": "true"
    ]
    
    let postSession = URLSession(configuration: .default)

    func getPosts(_ completion: @escaping (Result<[Product]>) -> ()) {
        
        do{
            
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: .posts, with: parameters, and: .get, contains: nil)
            postSession.dataTask(with: request) { (data, res, err) in
                
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                
                    case .success:
                        
                        let result = try? JSONDecoder().decode(ProductList.self, from: unwrappedData)
                        completion(Result.success(result!.posts))
                        
                    case .failure:
                        completion(Result.failure(HTTPNetworkError.decodingFailed))
                    }
                }
            }.resume()
        }catch{
            completion(Result.failure(HTTPNetworkError.badRequest))
        }
    }
}
