//
//  MainPresenter.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation
import UIKit
import CoreData

protocol MainInteractorOutput: AnyObject {

	func presentCoreData(_ data: [NSManagedObject])
}

protocol MainViewControllerOutput: AnyObject {

	func routeToEditScene(
		from view: UIViewController,
		to mode: EditViewController.Mode
	)

	func fetchCoreData()
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

	func fetchCoreData() {
		interactor?.fetchCoreData()
	}

	func presentCoreData(_ data: [NSManagedObject]) {
		view?.presentCoreData(data)
	}
}
