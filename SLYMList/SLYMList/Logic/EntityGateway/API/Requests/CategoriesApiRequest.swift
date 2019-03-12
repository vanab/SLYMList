//
//  CategoriesApiRequest.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import Foundation

struct CategoriesApiRequest: ApiRequest {
    var urlRequest: URLRequest {
        let url = URL(string: "https://money.yandex.ru/api/categories-list")!
        let request = try! URLRequest(url: url, method: .get)
        return request
    }
}
