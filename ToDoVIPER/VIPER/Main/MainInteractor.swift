//
//  MainInteractor.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation
import CoreData

protocol MainInteractorInput:AnyObject {

	func fetchCoreData()
	
}

final class MainInteractor {

	var presenter: MainInteractorOutput?

	private var coreDataWorker: CoreDataWorker

	init(coreDataWorker: CoreDataWorker) {
		self.coreDataWorker = coreDataWorker
	}


}

extension MainInteractor: MainInteractorInput {

	func fetchCoreData() {
		coreDataWorker.fetchCoreData { data in
			presenter?.presentCoreData(data)
		}
	}
}
