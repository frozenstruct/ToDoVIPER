//
//  ToDoItem+CoreDataProperties.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 19.12.2021.
//
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var done: Bool
    @NSManaged public var dueDate: Date?
    @NSManaged public var list: NSObject?
    @NSManaged public var name: String?
    @NSManaged public var subtasks: NSObject?

}
