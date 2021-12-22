//
//  EditInteractor.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation

protocol EditInteractorInput: AnyObject {

	func getRawValuesFromView(_ values: RawInputValues)

	func saveToCoreData(data: RawInputValues)

	func updateObject(from container: CoreDataRelayContainer)
}

final class EditInteractor{

	var presenter: EditInteractorOutput?

	var coreDataWorker: CoreDataWorker

	init(coreDataWorker: CoreDataWorker) {
		self.coreDataWorker = coreDataWorker
	}
}

extension EditInteractor: EditInteractorInput {

	func getRawValuesFromView(_ values: RawInputValues) {
		coreDataWorker.rawValues = values
	}

	func saveToCoreData(data: RawInputValues) {
		coreDataWorker.saveToContext(data: data)
	}

	func updateObject(from container: CoreDataRelayContainer) {
		coreDataWorker.updateObject(from: container)
	}
}
