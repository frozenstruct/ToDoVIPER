//
//  MainInteractor.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation
import CoreData

protocol MainInteractorInput:AnyObject { }

final class MainInteractor: MainInteractorInput {

	var presenter: MainInteractorOutput?
}
