//
//  MainViewController.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation
import UIKit

protocol MainViewControllerInput: AnyObject { }


final class MainViewController: UITableViewController, MainViewControllerInput {

	// MARK: - VIPER

	var presenter: MainViewControllerOutput?

	// MARK: - Props

	var dataSource: [String] = ["awrge", "asrg", "aserg", "awegr", "awrg"]

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationController?.navigationBar.isHidden = false
		navigationController?.navigationBar.prefersLargeTitles = true

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

		cell.textLabel?.text = dataSource[indexPath.row]

		return cell
	}
}
