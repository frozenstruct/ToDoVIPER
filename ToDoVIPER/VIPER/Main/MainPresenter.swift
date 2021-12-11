//
//  MainPresenter.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation
import UIKit

protocol MainInteractorOutput: AnyObject { }

protocol MainViewControllerOutput: AnyObject {

	func routeToEditScene(
		from view: UIViewController,
		to mode: EditViewController.Mode
	)
}

final class MainPresenter: MainInteractorOutput & MainViewControllerOutput {

	var interactor: MainInteractorInput?
	var view: MainViewControllerInput?
	var router: MainRouterInput?
}

extension MainPresenter {

	func routeToEditScene(
		from view: UIViewController,
		to mode: EditViewController.Mode
	) {
		router?.routeToEditScene(
			from: view,
			to: mode
		)
	}
}
