//
//  ApiClient.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ApiRequest {
    var urlRequest: URLRequest { get }
}

protocol ApiClient {
    func execute<T>(request: ApiRequest, completionHandler: @escaping (_ result: Result<ApiResponse<T>>) -> Void)
}


class ApiClientImpl: ApiClient {
    var urlRequest: URLRequest
    
    init(request: URLRequest) {
        urlRequest = request
    }
    
    func execute<T>(request: ApiRequest, completionHandler: @escaping (Result<ApiResponse<T>>) -> Void) {
        URLCache.shared.removeAllCachedResponses()
        Alamofire.request(urlRequest).responseJSON { (response) in
            switch response.result {
            case .success(let res):
                do {
                    let json = JSON(res)
                    let responseObj = try ApiResponse<T>(json: json, httpUrlResponse: response.response!)
                    completionHandler(.success(responseObj))
                } catch {
                    completionHandler(.failure(error))
                }
                
            case .failure(let err):
                completionHandler(.failure(err))
            }
        }
    }
}

struct ApiResponse<T: InitializableWithJson> {
    let entity: T
    let httpUrlResponse: HTTPURLResponse
    let json: JSON?
    
    init(json: JSON, httpUrlResponse: HTTPURLResponse) throws {
        do {
            self.entity = try T(json: json)
            self.httpUrlResponse = httpUrlResponse
            self.json = json
        } catch {
            throw ApiParseError(error: error, httpUrlResponse: httpUrlResponse, json: json)
        }
    }
}

struct ApiParseError: Error {
    static let code = 999
    
    let error: Error
    let httpUrlResponse: HTTPURLResponse
    let json: JSON?
    
    var localizedDescription: String {
        return error.localizedDescription
    }
}

extension NSError {
    static func createParseError() -> NSError {
        return NSError(domain: "categoriesList",
                       code: ApiParseError.code,
                       userInfo: [NSLocalizedDescriptionKey: "parse error"])
    }
}
