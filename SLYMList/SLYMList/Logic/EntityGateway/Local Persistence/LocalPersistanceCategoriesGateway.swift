//
//  LocalPersistanceCategoriesGateway.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import Foundation
import CoreData

protocol LocalPersistenceCategoriesGateway: CategoriesGateway {
    func save(categories: [Category])
}

class CoreDataCategoriesGateway: LocalPersistenceCategoriesGateway {
    let viewContext: NSManagedObjectContextProtocol
    
    init(viewContext: NSManagedObjectContextProtocol) {
        self.viewContext = viewContext
    }
    
    func save(categories: [Category]) {
        do {
            let oldObjects = try viewContext.allEntities(withType: CDCategory.self)
            viewContext.delete(oldObjects)
        } catch {
            print("old objects fail")
        }
        for cat in categories {
            guard let newCDCategory = viewContext.addEntity(withType: CDCategory.self) else { return }
            newCDCategory.populate(with: cat)
        }
        do {
            try viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchCategories(completionHandler: @escaping FetchCategoriesEntityGatewayCompletionHandler) {
        let predicate = NSPredicate(format: "parent == nil")
        if let coreDataCategories = try? viewContext.allEntities(withType: CDCategory.self,
                                                                 predicate: predicate) {
            let cats = coreDataCategories.map{ return $0.category }
            if cats.count > 0 {
                completionHandler(.success(cats))
            }
            else {
                completionHandler(.failure(CoreError(message: "No data in db")))
            }
        } else {
            completionHandler(.failure(CoreError(message: "Failed retrieving categories the data base")))
        }
    }
}
