//
//  MainPresenter.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation

protocol MainInteractorOutput { }
protocol MainViewControllerOutput: AnyObject { }

final class MainPresenter: MainInteractorOutput & MainViewControllerOutput {

	var interactor: MainInteractorInput?
	var view: MainViewControllerInput?
	var router: MainRouterInput?
}
