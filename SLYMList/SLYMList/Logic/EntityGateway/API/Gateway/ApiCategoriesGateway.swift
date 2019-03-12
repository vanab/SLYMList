//
//  ApiCategoriesGateway.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol ApiCategoriesGateway: CategoriesGateway {}

class ApiCategoriesGatewayImpl: ApiCategoriesGateway {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchCategories(completionHandler: @escaping FetchCategoriesEntityGatewayCompletionHandler) {
        let categoriesApiRequest = CategoriesApiRequest()
        apiClient.execute(request: categoriesApiRequest) { (res: Result<ApiResponse<[ApiCategory]>>) in
            switch res {
            case .success(let obj):
                let cats = obj.entity.map{ return $0.category }
                completionHandler(.success(cats))
            case .failure(let err):
                completionHandler(.failure(err))
            }
        }
    }
}

extension Array: InitializableWithJson {
    init(json: JSON) throws {
        guard let element = Element.self as? InitializableWithJson.Type, let jsonArray = json.array else {
            throw NSError.createParseError()
        }
        
        self = try jsonArray.map( { return try element.init(json: $0) as! Element } )
    }
}
