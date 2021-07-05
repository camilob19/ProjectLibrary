//
//  CoreDataManager.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 5/07/21.
//

import Foundation
import CoreData

enum Entities {
    case favorites
    case rentals
}

class CoreDataManager {
    
    var context: NSManagedObjectContext!
    
    init() {
        let contextClass = CoreDataContext()
        context = contextClass.mainContext
    }
    
    func find(id: Int, in entity: Entities) -> Bool {
        switch entity {
        case .favorites:
            return findFavorite(id: id)
        case .rentals:
            return findRentals(id: id)
        }
    }
    
    private func findFavorite(id: Int) -> Bool {
        let frq: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        frq.predicate = NSPredicate(format: "idBook == \(id)")
        do {
            let contextResults = try context.fetch(frq)
            return !(contextResults.first == nil)
        } catch {
            return false
        }
    }
    
    private func findRentals(id: Int) -> Bool {
        let frq: NSFetchRequest<Rentals> = Rentals.fetchRequest()
        frq.predicate = NSPredicate(format: "idBook == \(id)")
        do {
            let contextResults = try context.fetch(frq)
            return !(contextResults.first == nil)
        } catch {
            return false
        }
    }
    
    func saveFavorite(id: Int) -> Bool {
        guard let entitiy = NSEntityDescription.entity(forEntityName: "Favorites", in: context) else {
            return false
        }
        let favoriteEntity = Favorites(entity: entitiy, insertInto: context)
        favoriteEntity.idBook = Int64(id)

        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func saveRentals(id: Int) -> Bool {
        guard let entitiy = NSEntityDescription.entity(forEntityName: "Rentals", in: context) else {
            return false
        }
        let favoriteEntity = Rentals(entity: entitiy, insertInto: context)
        favoriteEntity.idBook = Int64(id)

        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func deleteData(_ entity: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
}
