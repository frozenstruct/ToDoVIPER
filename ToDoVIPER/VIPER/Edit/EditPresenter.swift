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
}

final class EditPresenter: EditViewControllerOutput {

	var interactor: EditInteractorInput?
	var view: EditViewControllerInput?
	var router: EditRouterInput?
}

extension EditPresenter: EditInteractorOutput {

	func saveToCoreData(data: RawInputValues) {
		interactor?.saveToCoreData(data: data)
	}
}
