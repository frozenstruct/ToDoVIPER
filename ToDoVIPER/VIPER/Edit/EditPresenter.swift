//
//  EditPresenter.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation

protocol EditInteractorOutput: AnyObject { }
protocol EditViewControllerOutput: AnyObject {

	func saveToCoreData(data: RawInputValues)
	func updateObject(from container: CoreDataRelayContainer)
}

final class EditPresenter {

	var interactor: EditInteractorInput?
	var view: EditViewControllerInput?
	var router: EditRouterInput?
}

extension EditPresenter: EditViewControllerOutput {

	func saveToCoreData(data: RawInputValues) {
		interactor?.saveToCoreData(data: data)
	}

	func updateObject(from container: CoreDataRelayContainer) {
		interactor?.updateObject(from: container)
	}
}

extension EditPresenter: EditInteractorOutput { }
