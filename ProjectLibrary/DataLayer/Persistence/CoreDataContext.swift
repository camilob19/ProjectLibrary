//
//  CoreDataContext.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 5/07/21.
//

import Foundation
import CoreData

class CoreDataContext {
    static let modelName = "DataModel"

    static let model: NSManagedObjectModel = {
      // swiftlint:disable force_unwrapping
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        
      return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    // swiftlint:enable force_unwrapping

    public init() { }

    public lazy var mainContext: NSManagedObjectContext = {
        return storeContainer.viewContext
    }()
    
    public lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataContext.modelName,
                                              managedObjectModel: CoreDataContext.model)
        let storeURL = try! FileManager
            .default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("DataModel.sqlite")

        let persistentStoreDescription = NSPersistentStoreDescription(url: storeURL)
        persistentStoreDescription.type = NSSQLiteStoreType
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
     
      return container
    }()
}
