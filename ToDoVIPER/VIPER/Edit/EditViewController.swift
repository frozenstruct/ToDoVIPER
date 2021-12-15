//
//  EditViewController.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import CoreData
import UIKit

// TODO: - To Interactor
// TODO: 	- To Worker
typealias RawInputValues = (
	name: String,
	done: String,
	dueDate: String,
	estimation: String,
	list: String,
	projects: String,
	subtasks: String,
	tags: String
)

protocol EditViewControllerInput: AnyObject { }

final class EditViewController: UIViewController, EditViewControllerInput {

	// MARK: - Subtypes

	enum Mode {
		case create
		case edit
	}

	// MARK: - VIPER

	var presenter: EditViewControllerOutput?

	// MARK: - UI Parts

	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var nameTextField: UITextField!
	@IBOutlet private weak var statusTextField: UITextField!
	@IBOutlet private weak var dueDateTextField: UITextField!
	@IBOutlet private weak var estimationTextField: UITextField!
	@IBOutlet private weak var subtasksTextField: UITextField!
	@IBOutlet private weak var listTextField: UITextField!
	@IBOutlet private weak var tagsTextField: UITextField!
	@IBOutlet private weak var projectsTextField: UITextField!
	@IBOutlet private weak var saveButton: UIButton!

	// MARK: - Properties

	private var todos: [NSManagedObject] = []

	private var mode: Mode

	// MARK: - Initialization

	init(mode: Mode) {
		self.mode = mode
		super.init(
			nibName: String(describing: EditViewController.self),
			bundle: nil
		)
	}

	required init?(coder: NSCoder) {
		mode = .create
		super.init(coder: coder)
	}

	// MARK: - View Life Cycle

	override class func awakeFromNib() {
		super.awakeFromNib()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setTitleLabel()
	}

	// MARK: - UI Assembly

	func setTitleLabel() {
		switch mode {
		case .edit:
			titleLabel.text = "ToDoName"
		case .create:
			titleLabel.text = "Create ToDo"
		}
	}

	// MARK: - Methods

	// TODO: - To Interactor
	@IBAction func saveAction(_ sender: Any) {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
		else {
			return
		}

		/// NSManagedObjectContext
		///
		/// What it is:
		/// 	Get managed object context here
		/// 	It is a space of object models – they represent the particular persistent store
		/// 	Changes are in memory until the're saved to the presistent store
		/// 	Managed object instance is unique to particular context
		///
		/// Context manages objects'life cycle:
		/// 	Fetch / alter properites / discard changes / commit changes back
		/// 	Maintaining `undo` operations
		/// 	Destroying objects
		///
		/// Saving new object:
		/// 	Insert new object
		/// 	`Commit` the changes
		///
		/// - Note: Default contenxt is in `AppDelegate`'s `persistentContrainer` if CoreData was ticked
		// TODO: - To Worker
		let managedContext = appDelegate.persistentContainer.viewContext

		/// NSEntityDescription
		///
		/// What it is:
		/// 	Specifies metadata (properties / relationships / name (kek))
		/// 	Maps managed objects in app to persistent stores
		guard let entity = NSEntityDescription.entity(
			forEntityName: Strings.ToDoItemModel.entity.rawValue,
			in: managedContext
		)
		else {
			return
		}

		let rawValues = getOutletValues()
		let coreDataValues = convertToCoreDataTypes(rawData: rawValues)

		/// NSManagedObject
		/// 	This is a base coreData object reference to model
		/// 	Associated with NSEntityDescription (metadata)
		let toDoCoreDataItem = NSManagedObject(
			entity: entity,
			insertInto: managedContext
		)
		
		toDoCoreDataItem.setValue(
			coreDataValues[Strings.ToDoItemModel.estimation.rawValue],
			forKeyPath: Strings.ToDoItemModel.estimation.rawValue
		)

		do {
			try managedContext.save()
		}
		catch let error as NSError {
			print("\(error.userInfo)")
		}

		dismiss(animated: true, completion: nil)
	}


	// TODO: - To Interactor
	// TODO: 	- To Worker
	private func getOutletValues() -> RawInputValues {
		let name = nameTextField.text ?? ""
		let done = statusTextField.text ?? ""
		let dueDate = dueDateTextField.text ?? ""
		let estimation = estimationTextField.text ?? ""
		let subtasks = subtasksTextField.text ?? ""
		let list = listTextField.text ?? ""
		let tags = tagsTextField.text ?? ""
		let projects = projectsTextField.text ?? ""

		// TODO: - Make Typealias
		let rawValues = (
			name: name,
			done: done,
			dueDate: dueDate,
			estimation: estimation,
			list: list,
			projects: projects,
			subtasks: subtasks,
			tags: tags
		)

		return rawValues
	}

	// TODO: - To Interactor
	// TODO: 	- To Worker
	private func convertToCoreDataTypes(rawData: RawInputValues) -> [String: Any] {
		let rawData = rawData
		let name = rawData.name
		let done = toBool(rawData.done)
		let dueDate = toDate(rawData.dueDate)
		let estimation = Int(rawData.estimation) ?? 0

		// TODO: - Finish here
		//		let list = Int.random(in: 0...100)
		//		let subtasks = Int.random(in: 0...100)
		//		let tags = Int.random(in: 0...100)
		//		let projects = Int.random(in: 0...100)

		return [
			Strings.ToDoItemModel.done.rawValue : done,
			Strings.ToDoItemModel.dueDate.rawValue : dueDate,
			Strings.ToDoItemModel.estimation.rawValue : estimation,
			//			Strings.ToDoItemModel.list.rawValue : list,
			Strings.ToDoItemModel.name.rawValue : name
			//			Strings.ToDoItemModel.projects.rawValue : projects,
			//			Strings.ToDoItemModel.subtasks.rawValue : subtasks,
			//			Strings.ToDoItemModel.tags.rawValue : tags,
		]

	}

	// TODO: 	- To worker
	private func toBool(_ input: String) -> Bool {
		return input == "done" ? true : false
	}

	// TODO: 	- To worker
	// TODO: 	- Finish
	private func toDate(_ input: String) -> Date {
		return DateFormatter().date(from: input) ?? Date()
	}


}
