//
//  DisplayCategories.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import Foundation


struct CoreError: Error {
    var localizedDescription: String {
        return message
    }
    
    var message = ""
}

// https://github.com/antitypical/Result
enum Result<T> {
    case success(T)
    case failure(Error)
    
    public func dematerialize() throws -> T {
        switch self {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }
}

typealias DisplayCategoriesUseCaseCompletionHandler = (_ categories: Result<[Category]>) -> Void

protocol DisplayCategoriesUseCase {
    func displayCategories(completionHandler: @escaping DisplayCategoriesUseCaseCompletionHandler)
}

class DisplayCategoriesListUseCaseImplementation: DisplayCategoriesUseCase {

    let categoriesGateway: CategoriesGateway
    
    init(categoriesGateway: CategoriesGateway) {
        self.categoriesGateway = categoriesGateway
    }
    
    // MARK: - DisplayCategoriesUseCase
    func displayCategories(completionHandler: @escaping DisplayCategoriesUseCaseCompletionHandler) {
        categoriesGateway.fetchCategories { (res) in
            completionHandler(res)
        }
    }
}
