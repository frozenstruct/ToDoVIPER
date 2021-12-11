//
//  EditInteractor.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation

protocol EditInteractorInput: AnyObject { }

final class EditInteractor: EditInteractorInput {

	var presenter: EditInteractorOutput?
}
