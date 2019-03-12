//
//  Category.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import Foundation

struct Category {
    var title: String
    var id: Int?
    var subs: [Category]
}

struct CategoryLeveled {
    var title: String
    var level: Int
}
