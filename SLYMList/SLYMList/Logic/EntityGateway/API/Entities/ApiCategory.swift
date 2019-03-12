//
//  ApiCategory.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol InitializableWithJson {
    init(json: JSON) throws
}

class ApiCategory: InitializableWithJson {
    var title: String
    var id: Int?
    var subs = [ApiCategory]()
    weak var parent: ApiCategory?
    
    required init(json: JSON) throws {
        guard let title = json["title"].string else {
            throw NSError.createParseError()
        }
        self.title = title
        self.id = json["id"].int
        if let subsArr = json["subs"].array {
            subsArr.forEach { (json) in
                let subCategory = try! ApiCategory(json: json)
                subCategory.parent = self
                subs.append(subCategory)
            }
        }
    }
    
}

extension ApiCategory {
    var category: Category {
        var rootCategory = Category(title: title,
                                    id: id,
                                    subs: [])
        let subCategories = self.subCategories(startLevel: 2)
        rootCategory.subs = subCategories
        return rootCategory
    }
    
    func subCategories(startLevel: Int) -> [Category]{
        var cats = [Category]()
        for sub in subs {
            var subCategory = Category(title: sub.title,
                                       id: sub.id,
                                       subs: [])
            let subSubCats = sub.subCategories(startLevel: startLevel + 1)
            subCategory.subs = subSubCats
            cats.append(subCategory)
        }
        return cats
    }
}
