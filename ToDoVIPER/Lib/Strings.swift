//
//  Strings.swift
//  ToDoVIPER
//
//  Created by Dmitry Aksyonov on 11.12.2021.
//

import Foundation

struct Strings {

	enum ToDoItemModel: String {

		case entity = "ToDoItem"

		case done = "done"
		case dueDate = "dueDate"
		case estimation = "estimation"
		case list = "list"
		case name = "name"
		case projects = "projects"
		case subtasks = "subtasks"
		case tags = "tags"
	}

	enum SubtaskModel: String {
		case entity = "SubTask"

		case estimation = "estimation"
		case isPartOf = "isPartOf"
		case name = "name"
	}
}
