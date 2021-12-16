//
//  MainAssembler.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import UIKit

final class MainAssembler {

	func make() -> UIViewController {
		guard let view = UIStoryboard.init(
			name: "Main", bundle: nil
		).instantiateViewController(
			withIdentifier: "mainVC"
		) as? MainViewController
		else {
			return UIViewController()
		}

		let interactor = MainInteractor(coreDataWorker: .shared)
		let presenter = MainPresenter()
		let router = MainRouter()

		view.presenter = presenter
		presenter.interactor = interactor
		presenter.view = view
		presenter.router = router
		interactor.presenter = presenter

		let navigationController = UINavigationController(rootViewController: view)

		return navigationController
	}
}
