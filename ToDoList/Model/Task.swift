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
}
