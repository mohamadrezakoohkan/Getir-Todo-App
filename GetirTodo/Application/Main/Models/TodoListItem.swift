//
//  TodoListItem.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine

enum TodoListItem: String {

    case todo = "Todo"
    case completed = "Completed"
    case deleted = "Deleted"
    
    var todos: [Todo] {
        switch self {
        case .todo:
            return Main.shared.database.todos.todo
        case .completed:
            return Main.shared.database.todos.completed
        case .deleted:
            return Main.shared.database.todos.deleted
        }
    }
    
    var subject: PassthroughSubject<[Todo], Never> {
        switch self {
        case .todo:
            return Main.shared.database.todosSubject
        case .completed:
            return Main.shared.database.completedSubject
        case .deleted:
            return Main.shared.database.deletedSubject
        }
    }
}
