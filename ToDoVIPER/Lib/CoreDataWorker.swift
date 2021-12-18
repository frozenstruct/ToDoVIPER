//
//  CoreDataWorker.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 16.12.2021.
//

import UIKit
import CoreData

typealias RawInputValues = (
	name: String,
	done: String,
	dueDate: String,
	subtasks: String
)

protocol CoreDataWorkerProtocol: AnyObject {

}

final class CoreDataWorker: CoreDataWorkerProtocol {

	// MARK: - Properties

	static let shared = CoreDataWorker()

	var dataSource: [NSManagedObject] = []

	var rawValues: RawInputValues?

	// MARK: - Singleton Imp

	private init() { }

	// MARK: - Fetch

	func fetchCoreData(_ completion: ([NSManagedObject]) -> Void) {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
		else {
			return
		}

		let managedContext = appDelegate.persistentContainer.viewContext

		let fetchRequest = NSFetchRequest<NSManagedObject>(
			entityName: Strings.ToDoItemModel.entity.rawValue
		)

		do {
			dataSource = try managedContext.fetch(fetchRequest)
			completion(dataSource)
		} catch let error as NSError {
			print("\(error), \(error.userInfo)")
		}
	}

	// MARK: - Save

	func saveToContext(data: RawInputValues) {

		// TODO: - Refactor
		/// https://github.com/daksyonov/ToDoVIPER/issues/3
		self.rawValues = data

		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
		else {
			return
		}

		let managedContext = appDelegate.persistentContainer.viewContext

		guard let entity = NSEntityDescription.entity(
			forEntityName: Strings.ToDoItemModel.entity.rawValue,
			in: managedContext
		)
		else {
			return
		}

		if let values = rawValues {
			let coreDataValues = convertToCoreDataTypes(rawData: values)

			let toDoCoreDataItem = NSManagedObject(
				entity: entity,
				insertInto: managedContext
			)

			toDoCoreDataItem.setValuesForKeys(coreDataValues)

			do {
				try managedContext.save()
			}
			catch let error as NSError {
				print("\(error.userInfo)")
			}
		}
	}


	// MARK: - Conversion Methods

	private func convertToCoreDataTypes(rawData: RawInputValues) -> [String: Any] {
		let rawData = rawData
		let name = rawData.name
		let done = toBool(rawData.done)
		let dueDate = toDate(rawData.dueDate)


		// TODO: - Finish here
		let list = Int.random(in: 0...100)
		let subtasks = Int.random(in: 0...100)


		return [
			Strings.ToDoItemModel.done.rawValue : done,
			Strings.ToDoItemModel.dueDate.rawValue : dueDate,

			Strings.ToDoItemModel.list.rawValue : list,
			Strings.ToDoItemModel.name.rawValue : name,

			Strings.ToDoItemModel.subtasks.rawValue : subtasks

		]
	}

	private func toBool(_ input: String) -> Bool {
		return input == "done" ? true : false
	}

	private func toDate(_ input: String) -> Date {
		return DateFormatter().date(from: input) ?? Date()
	}
}
