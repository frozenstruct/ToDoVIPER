//
//  EditViewController.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation
import UIKit

protocol EditViewControllerInput: AnyObject { }

final class EditViewController: UITableViewController, EditViewControllerInput, UITableViewDragDelegate {

	// MARK: - VIPER

	var presenter: EditViewControllerOutput?

	// MARK: - Props

	var dataSource: [String] = ["awrge", "asrg", "aserg", "awegr", "awrg"]

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationController?.navigationBar.isHidden = false
		navigationController?.navigationBar.prefersLargeTitles = true

		tableView.dragInteractionEnabled = true
		tableView.dragDelegate = self

		navigationItem.rightBarButtonItem = editButtonItem
	}
}

// MARK: - TableView DataSource

extension EditViewController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSource.count
	}

	override func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell")
		else {
			return UITableViewCell()
		}

		cell.textLabel?.text = dataSource[indexPath.row]

		return cell
	}
}

// MARK: - TableView Delegate

extension EditViewController {

	override func tableView(
		_ tableView: UITableView,
		commit editingStyle: UITableViewCell.EditingStyle,
		forRowAt indexPath: IndexPath
	) {
		if editingStyle == .delete {
			dataSource.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
}

// MARK: - TableView Drag & Drop

extension EditViewController {

	override func tableView(
		_ tableView: UITableView,
		moveRowAt sourceIndexPath: IndexPath,
		to destinationIndexPath: IndexPath
	) {
		let mover = dataSource.remove(at: sourceIndexPath.row)
		dataSource.insert(mover, at: destinationIndexPath.row)
	}

	func tableView(
		_ tableView: UITableView,
		itemsForBeginning session: UIDragSession,
		at indexPath: IndexPath
	) -> [UIDragItem] {
		let currentItem = dataSource[indexPath.row]
		let dragItem = UIDragItem(itemProvider: NSItemProvider())
		dragItem.localObject = currentItem

		return [dragItem]
	}
}