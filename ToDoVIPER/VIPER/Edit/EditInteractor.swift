//
//  EditInteractor.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation

protocol EditInteractorInput: AnyObject {

	func getRawValuesFromView(_ values: RawInputValues)
}

final class EditInteractor: EditInteractorInput {

	var presenter: EditInteractorOutput?

	var coreDataWorker: CoreDataWorker

	init(coreDataWorker: CoreDataWorker) {
		self.coreDataWorker = coreDataWorker
	}

	func getRawValuesFromView(_ values: RawInputValues) {
		coreDataWorker.rawValues = values
	}
}
