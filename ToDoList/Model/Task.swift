//
//  Task.swift
//  ToDoList
//
//  Created by Aleksey on 0510..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
	
	@objc dynamic var text = ""
	@objc dynamic var created = Date()
	@objc dynamic var completed = false
	
	
	static func createTask(text: String, completed: Bool = false) -> Task {
		let task = Task()
		task.text = text
		task.completed = completed
		return task
	}
	
	
	static func createPersistedTask() -> Task? {
		let task = Task()
		do {
			let realm = try Realm()
			try Realm().write {
				realm.add(task)
			}
		} catch let error as NSError {
			print("Realm error while saving Task: \(error.userInfo)")
			return nil
		}
		
		return task
	}
	
	
	static func getAllTasks() -> Results<Task> {
		return try! Realm().objects(Task.self) // make it crash if something is wrong
	}
	
	
	func setText(_ text: String) {
		do {
			try Realm().write {
				self.text = text
			}
		} catch let error as NSError {
			print("Realm error while setting text: \(error.userInfo)")
		}
	}
	
	
	func setCompleted(_ completed: Bool) {
		do {
			try Realm().write {
				self.completed = completed
			}
		} catch let error as NSError {
			print("Realm error while setting text: \(error.userInfo)")
		}
	}
	
	
	func delete() {
		do {
			let realm = try Realm()
			try realm.write {
				realm.delete(self)
			}
		} catch let error as NSError {
			print("Realm error while setting text: \(error.userInfo)")
		}
	}
}
