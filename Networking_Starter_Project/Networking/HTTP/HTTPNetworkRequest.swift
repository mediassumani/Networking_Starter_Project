//
//  HTTPNetworkRequest.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/16/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders = [String: Any]?

struct HTTPNetworkRequest {
    
    /// Set the body, method, headers, and paramaters of the request
    static func configureHTTPRequest(from url: String, with parameters: HTTPParameters, includes headers: HTTPHeaders, contains body: Data?, and method: HTTPMethod) throws -> URLRequest {
        
        guard let url = URL(string: url) else { fatalError("Error while unwrapping url")}
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        try configureParametersAndHeaders(parameters: parameters, headers: headers, request: &request)
        
        return request
    }
    
    /// Configure the request parameters and headers before the API Call
    static func configureParametersAndHeaders(parameters: HTTPParameters?,
                                         headers: HTTPHeaders?,
                                         request: inout URLRequest) throws {

        do {

            if let headers = headers, let parameters = parameters {
                try URLEncoder.encodeParameters(for: &request, with: parameters)
                try URLEncoder.setHeaders(for: &request, with: headers)
            }
        } catch {
            throw HTTPNetworkError.encodingFailed
        }
    }
    
}
