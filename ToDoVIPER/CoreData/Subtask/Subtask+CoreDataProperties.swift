//
//  Subtask+CoreDataProperties.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 19.12.2021.
//
//

import Foundation
import CoreData


extension Subtask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subtask> {
        return NSFetchRequest<Subtask>(entityName: "Subtask")
    }

    @NSManaged public var estimation: Int32
    @NSManaged public var isPartOf: String?
    @NSManaged public var name: String?

}
