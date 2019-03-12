//
//  CoreDataStack.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import Foundation
import CoreData

//copy - paste 90%


protocol CoreDataStack {
    var persistentContainer: NSPersistentContainer { get }
    func saveContext()
}

class CoreDataStackImplementation {
    
    static let sharedInstance = CoreDataStackImplementation()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
