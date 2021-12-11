//
//  MainRouter.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation
import UIKit

protocol MainRouterInput: AnyObject {

	func routeToEditScene(
		from view: UIViewController,
		to mode: EditViewController.Mode
	)
}

final class MainRouter: MainRouterInput {

}

extension MainRouter {

	func routeToEditScene(
		from view: UIViewController,
		to mode: EditViewController.Mode
	) {
		let viewController = EditAssembler().make(mode: mode)
		view.present(viewController, animated: true, completion: nil)
	}
}
