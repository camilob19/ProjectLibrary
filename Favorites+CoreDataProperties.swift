//
//  Favorites+CoreDataProperties.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 5/07/21.
//
//

import Foundation
import CoreData

extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var idBook: Int64

}

extension Favorites : Identifiable {

}
