//
//  Rentals+CoreDataProperties.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 5/07/21.
//
//

import Foundation
import CoreData

extension Rentals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rentals> {
        return NSFetchRequest<Rentals>(entityName: "Rentals")
    }

    @NSManaged public var idBook: Int64

}

extension Rentals : Identifiable {

}
