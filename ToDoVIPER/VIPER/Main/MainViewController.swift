//
//  MainViewController.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import CoreData
import UIKit

protocol MainViewControllerInput: AnyObject {

	func presentCoreData(_ data: [NSManagedObject])
}

typealias TableViewDragging =  UITableViewDragDelegate

final class MainViewController: UITableViewController, MainViewControllerInput, UITableViewDragDelegate {

	// MARK: - VIPER

	var presenter: MainViewControllerOutput?

	// MARK: - Properties

	private var dataSource: [ToDoItem] = []

	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

		presenter?.fetchCoreData()

		navigationController?.navigationBar.isHidden = false
		navigationController?.navigationBar.prefersLargeTitles = true

		tableView.dragInteractionEnabled = true
		tableView.dragDelegate = self

		navigationItem.rightBarButtonItem = editButtonItem
	}

	// MARK: - Methods

	@IBAction private func createNewToDo(_ sender: Any) {
		presenter?.routeToEditScene(from: self, to: .create, with: nil)
	}
}

// MARK: - TableView DataSource

extension MainViewController {

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

		let toDo = dataSource[indexPath.row]
		let toDoName = toDo.value(forKeyPath: "name") as? String
		let toDoDueDate = toDo.value(forKeyPath: "dueDate") as? String

		cell.textLabel?.text = toDoName
		cell.detailTextLabel?.text = toDoDueDate

		return cell
	}
}

// MARK: - TableView Delegate

extension MainViewController {

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

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let idx = indexPath.row
		let currentData = dataSource[indexPath.row]
		let transferObject = CoreDataRelayContainer(object: currentData, idx: idx)

		presenter?.routeToEditScene(
			from: self,
			to: .edit,
			with: transferObject
		)

	}
}

// MARK: - TableView Drag & Drop

extension MainViewController {

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

extension MainViewController {
	func presentCoreData(_ data: [NSManagedObject]) {
		dataSource = (data as? [ToDoItem]) ?? []
	}
}
