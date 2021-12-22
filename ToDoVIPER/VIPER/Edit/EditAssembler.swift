//
//  EditAssembler.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import UIKit
import CoreData

final class EditAssembler {

	func make(
		mode: EditViewController.Mode,
		data: CoreDataRelayContainer? = nil
	) -> UIViewController {
		let view = EditViewController(
			mode: mode,
			data: data
		)
		let interactor = EditInteractor(coreDataWorker: .shared)
		let presenter = EditPresenter()
		let router = EditRouter()

		view.presenter = presenter
		presenter.interactor = interactor
		presenter.view = view
		presenter.router = router
		interactor.presenter = presenter

		let navigationController = UINavigationController(rootViewController: view)

		return navigationController
	}
}
