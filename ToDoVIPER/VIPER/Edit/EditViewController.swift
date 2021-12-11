//
//  EditViewController.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import CoreData
import UIKit

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

	@IBAction func saveAction(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
}
