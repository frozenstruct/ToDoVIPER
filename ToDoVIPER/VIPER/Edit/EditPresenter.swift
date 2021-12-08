//
//  EditPresenter.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation

protocol EditInteractorOutput { }
protocol EditViewControllerOutput: AnyObject { }

final class EditPresenter: EditInteractorOutput & EditViewControllerOutput {

	var interactor: EditInteractorInput?
	var view: EditViewControllerInput?
	var router: EditRouterInput?
}
