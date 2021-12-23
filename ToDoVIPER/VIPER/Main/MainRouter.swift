//
//  MainRouter.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation
import UIKit
import CoreData

protocol MainRouterInput: AnyObject {

	func routeToEditScene(
		from view: UIViewController,
		to mode: EditViewController.Mode,
		with data: CoreDataRelayContainer?
	)
}

final class MainRouter: MainRouterInput {

}

extension MainRouter {

	func routeToEditScene(
		from view: UIViewController,
		to mode: EditViewController.Mode,
		with data: CoreDataRelayContainer? = nil
	) {
		let viewController = EditAssembler().make(
			mode: mode,
			data: data
		)

		view.present(viewController, animated: true, completion: nil)
	}
}
