//
//  EditViewController.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation
import UIKit

protocol EditViewControllerInput: AnyObject { }

final class EditViewController: UIViewController, EditViewControllerInput {

	// MARK: - VIPER

	var presenter: EditViewControllerOutput?

	// MARK: - Props

	@IBOutlet private weak var nameTextField: UITextField!
	@IBOutlet private weak var statusTextField: UITextField!
	@IBOutlet private weak var dueDateTextField: UITextField!
	@IBOutlet private weak var estimationTextField: UITextField!
	@IBOutlet private weak var subtasksTextField: UITextField!
	@IBOutlet private weak var listTextField: UITextField!
	@IBOutlet private weak var tagsTextField: UITextField!
	@IBOutlet private weak var projectsTextField: UITextField!
	@IBOutlet private weak var saveButton: UIButton!

	// MARK: - Methods

	@IBAction func saveAction(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

}
