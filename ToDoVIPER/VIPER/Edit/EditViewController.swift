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

	private var todos: [NSManagedObject] = []

	private var mode: Mode
	private var data: CoreDataRelayContainer?

	// MARK: - Initialization

	init(mode: Mode, data: CoreDataRelayContainer? = nil) {
		self.mode = mode
		self.data = data
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
			presenter?.updateObject(
				from: data!
			)
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
		guard let toDo = data,
			  mode == .edit
		else {
			return
		}

		fillOutletValues()
	}

	private func fillOutletValues() {
		let toDo = (data as? ToDoItem)

		nameTextField.text = (data as? ToDoItem)?.name
		statusTextField.text = "\(String(describing: (data as? ToDoItem)?.done))"
		dueDateTextField.text = "\(String(describing: (data as? ToDoItem)?.dueDate))"
		subtasksTextField.text = "\(String(describing: (data as? ToDoItem)?.subtasks))"
	}

	private func fillTransferContainer() {
		guard let object = data?.object as? ToDoItem
		else {
			return
		}

		let values = getOutletValues()
		object.name = "\(values.name)"
		object.done = Bool(exactly: NSNumber(integerLiteral: Int.random(in: 0...1))) ?? false
		object.dueDate = Date()
		object.subtasks = NSObject()
	}
}
