//
//  MainStrings.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/24/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

final class MainStrings: Singleton, StringTable {
    
    static var table: String = "Main"
    
    private static let _shared: MainStrings = .init()
    static var shared: MainStrings {
        return _shared
        
    }
    
    var create: String {
        return self.localize("main.create")
    }
    
    var edit: String {
        return self.localize("main.edit")
    }
    
    var task: String {
        return self.localize("main.task")
    }
    
    var update: String {
        return self.localize("main.update")
    }
    
    var editTask: String {
        return self.localize("main.edit.task")
    }
    
    var createTask: String {
        return self.localize("main.create.task")
    }
    
    var createTaskName: String {
        return self.localize("main.create.task.name")
    }
    
    var createTaskDate: String {
        return self.localize("main.create.task.date")
    }
    
    var createTaskDescription: String {
        return self.localize("main.create.task.description")
    }

    var editTaskName: String {
        return self.localize("main.edit.task.name")
    }
    
    var editTaskDate: String {
        return self.localize("main.edit.task.date")
    }
    
    var editTaskDescription: String {
        return self.localize("main.edit.task.description")
    }
}
