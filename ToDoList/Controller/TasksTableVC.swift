//
//  TasksTableVC.swift
//  ToDoList
//
//  Created by Aleksey on 0510..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class TasksTableVC: UITableViewController, TaskCellUpdating {
	
	func onTextViewChanged(text: String, object: Any?) {
		print(#function)
		if let task = object as? Task {
			task.setText(text)
		}
	}
	
	lazy var tasks = {
		return Task.getAllTasks()
	}()
	

    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
		tableView.register(UINib(nibName: "EmptyCell", bundle: nil), forCellReuseIdentifier: "EmptyCell")
		
    }
	
	
	func onAddTaskTapped() {
		let task = Task.createPersistedTask()
		if task != nil {
			tableView.reloadData()
			
			if let cell = tableView.visibleCells.filter({$0 is TaskCell }).last as? TaskCell {
				cell.beginEditing()
			}
		}
	}
	

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
	
	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tasks.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.row == tasks.count {
			return tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath)
		}
		
		let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
		cell.setCell(task.text, completed: task.completed)
		cell.updatingDelegate = self
		cell.object = task
        return cell
    }
	
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == tasks.count {
			onAddTaskTapped()
			return
		}
		
		let task = tasks[indexPath.row]
		task.setCompleted(!task.completed)
		
		tableView.reloadRows(at: [indexPath], with: .automatic)
	}
	
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let task = tasks[indexPath.row]
			task.delete()
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
	
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return indexPath.row < tasks.count
	}
}
