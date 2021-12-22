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
		to mode: EditViewController.Mode,
		with data: CoreDataRelayContainer?
	)

	func fetchCoreData()
}

final class MainPresenter {

	var interactor: MainInteractorInput?
	var view: MainViewControllerInput?
	var router: MainRouterInput?
}

extension MainPresenter: MainViewControllerOutput {

	func routeToEditScene(
		from view: UIViewController,
		to mode: EditViewController.Mode,
		with data: CoreDataRelayContainer? = nil
	) {
		router?.routeToEditScene(
			from: view,
			to: mode,
			with: data
		)
	}

	func fetchCoreData() {
		interactor?.fetchCoreData()
	}

}

extension MainPresenter: MainInteractorOutput {

	func presentCoreData(_ data: [NSManagedObject]) {
		view?.presentCoreData(data)
	}
}
