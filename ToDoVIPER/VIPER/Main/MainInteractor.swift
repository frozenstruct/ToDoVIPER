//
//  MainInteractor.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation

protocol MainInteractorInput { }

final class MainInteractor: MainInteractorInput {

	var presenter: MainInteractorOutput?

	var string: String = "let visi"
}
