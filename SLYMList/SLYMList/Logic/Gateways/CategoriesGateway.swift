//
//  CategoriesGateway.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import Foundation

typealias FetchCategoriesEntityGatewayCompletionHandler = (_ categories: Result<[Category]>) -> Void

protocol CategoriesGateway {
    func fetchCategories(completionHandler: @escaping FetchCategoriesEntityGatewayCompletionHandler)
}
