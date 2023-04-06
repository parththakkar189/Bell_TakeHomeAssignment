//
//  Vehicle+CoreDataProperties.swift
//  Guidomia2021
//
//  Created by Parth Thakkar on 2023-04-05.
//
//

import Foundation
import CoreData


extension Vehicle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vehicle> {
        return NSFetchRequest<Vehicle>(entityName: "Vehicle")
    }

    @NSManaged public var make: String?
    @NSManaged public var model: String?
    @NSManaged public var marketPrice: Float
    @NSManaged public var consList: [String]?
    @NSManaged public var prosList: [String]?
    @NSManaged public var customerPrice: Float
    @NSManaged public var rating: Int64

}

extension Vehicle : Identifiable {

}
