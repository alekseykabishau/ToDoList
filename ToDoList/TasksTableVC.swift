//
//  TasksTableVC.swift
//  ToDoList
//
//  Created by Aleksey on 0510..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class TasksTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }
	
	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        return cell
    }
}
