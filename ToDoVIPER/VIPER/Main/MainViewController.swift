//
//  MainViewController.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 01.12.2021.
//

import Foundation

protocol MainViewControllerInput: AnyObject { }


final class MainViewController: MainViewControllerInput {

	var output: MainViewControllerOutput?
}
