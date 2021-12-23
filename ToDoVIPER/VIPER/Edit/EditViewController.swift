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

	private var mode: Mode
	private var data: CoreDataRelayContainer?
	private var lastSavedName: String

	// MARK: - Initialization

	init(mode: Mode, data: CoreDataRelayContainer? = nil) {
		self.mode = mode
		self.data = data
		self.lastSavedName = data?.object.name ?? ""

		super.init(
			nibName: String(describing: EditViewController.self),
			bundle: nil
		)
	}

	required init?(coder: NSCoder) {
		mode = .create
		lastSavedName = ""
		super.init(coder: coder)
	}

	// MARK: - View Life Cycle

	override class func awakeFromNib() {
		super.awakeFromNib()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setTitleLabel()
		presentToDoForEditIfNeeded()
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
	@IBAction func finishFlowAction(_ sender: Any) {
		switch mode {
		case .edit:
			fillTransferContainer()
//			presenter?.updateObject(
//				from: data!
//			)
		case .create:
			let itemToSave = getOutletValues()
			presenter?.saveToCoreData(
				data: itemToSave
			)
		}

		dismiss(animated: true, completion: nil)
	}

	private func getOutletValues() -> RawInputValues {
		let name = nameTextField.text ?? ""
		let done = statusTextField.text ?? ""
		let dueDate = dueDateTextField.text ?? ""
		let subtasks = subtasksTextField.text ?? ""

		let rawValues: RawInputValues = (
			name: name,
			done: done,
			dueDate: dueDate,
			subtasks: subtasks
		)

		return rawValues
	}

	private func presentToDoForEditIfNeeded() {
		guard let _ = data,
			  mode == .edit
		else {
			return
		}

		fillOutletValues()
	}

	private func fillOutletValues() {
		nameTextField.text = data?.object.name
		statusTextField.text = "\(String(describing: data?.object.done))"
		dueDateTextField.text = "\(String(describing: data?.object.dueDate))"
		subtasksTextField.text = "\(String(describing: data?.object.subtasks))"
	}

	private func fillTransferContainer() {
		guard let managedContext = (
			UIApplication.shared.delegate as? AppDelegate
		)?.persistentContainer.viewContext
		else {
			return
		}

		let request = ToDoItem.fetchRequest()
		request.predicate = NSPredicate(
			format: "name = %@",
			self.lastSavedName as String
		)

		var fetchedToDo: [ToDoItem] = []

		do {
			try fetchedToDo = managedContext.fetch(request)
		} catch let error as NSError {
			print("error: \(error.userInfo)")
		}

		let toDoThatIsNeeded = fetchedToDo.first

		let values = getOutletValues()
		toDoThatIsNeeded?.name = "\(values.name)"
		toDoThatIsNeeded?.done = Bool(exactly: NSNumber(integerLiteral: Int.random(in: 0...1))) ?? false
		toDoThatIsNeeded?.dueDate = Date()
		toDoThatIsNeeded?.subtasks = NSObject()

		var _error = NSError()

		do {
			try managedContext.save()
		} catch let error as NSError {
			_error = error
			print(error)
		}
	}
}
