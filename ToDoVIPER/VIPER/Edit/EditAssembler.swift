//
//  EditAssembler.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import UIKit

final class EditAssembler {

	func make() -> UIViewController {
		guard let view = UIStoryboard.init(
			name: "Edit", bundle: nil
		).instantiateViewController(
			withIdentifier: "EditVC"
		) as? EditViewController
		else {
			return UIViewController()
		}

		let interactor = EditInteractor()
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
