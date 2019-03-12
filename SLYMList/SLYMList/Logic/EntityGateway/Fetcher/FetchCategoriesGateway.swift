//
//  FetchCategoriesGateway.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import Foundation

class FetchCategoriesGateway: CategoriesGateway {
    let apiCategoriesGateway: ApiCategoriesGateway
    let localPersistenceCategoriesGateway: LocalPersistenceCategoriesGateway
    
    init(apiCategoriesGateway: ApiCategoriesGateway,
         localPersistenceCategoriesGateway: LocalPersistenceCategoriesGateway) {
        self.apiCategoriesGateway = apiCategoriesGateway
        self.localPersistenceCategoriesGateway = localPersistenceCategoriesGateway
    }
    
    func fetchCategories(completionHandler: @escaping FetchCategoriesEntityGatewayCompletionHandler) {
        apiCategoriesGateway.fetchCategories(completionHandler: { (result) in
            self.handleFetchCategoriesApiResult(result, completionHandler: completionHandler)
        })
    }
    
    // MARK: - Private
    
    fileprivate func handleFetchCategoriesApiResult(_ result: Result<[Category]>, completionHandler: @escaping (Result<[Category]>) -> Void) {
        switch result {
        case let .success(cats):
            localPersistenceCategoriesGateway.save(categories: cats)
            completionHandler(result)
        case .failure(_): localPersistenceCategoriesGateway.fetchCategories(completionHandler: completionHandler)
        }
    }
}
