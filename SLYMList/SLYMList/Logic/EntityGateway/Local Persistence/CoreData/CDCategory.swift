//
//  CDCategory.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import Foundation
import CoreData

extension CDCategory {
    var category: Category {
        let id: Int = Int(self.id)
        var rootCategory = Category(title: name!,
                                    id: id,
                                    subs: [])
        
        let subCategories = self.subCategories(startLevel: 2)
        rootCategory.subs = subCategories
        return rootCategory
    }
    
    func subCategories(startLevel: Int) -> [Category]{
        var cats = [Category]()
        guard let subs = self.subs?.allObjects as? [CDCategory] else {return cats}
        for sub in subs {
            let id: Int? = Int(sub.id)
            var subCategory = Category(title: sub.name!,
                                       id: id,
                                       subs: [])
            let subSubCats = sub.subCategories(startLevel: startLevel + 1)
            subCategory.subs = subSubCats
            cats.append(subCategory)
        }
        return cats
    }
    
    
    func populate(with category: Category) {
        id = Int32(category.id ?? 0)
        name = category.title
        let subCategories = self.subCategories(category)
        subs = NSSet(array: subCategories)
    }
    
    func subCategories(_ category: Category) -> [CDCategory]{
        var cats = [CDCategory]()
        for sub in category.subs {
            guard let subCategory = managedObjectContext?.addEntity(withType: CDCategory.self) else { return []}
            subCategory.populate(with: sub)
            cats.append(subCategory)
        }
        return cats
    }
    
}
