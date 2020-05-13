//
//  MainDatabaseManager.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Foundation
import Combine

final class MainDatabaseManager: Singleton, Database {
    
    private static let _shared: MainDatabaseManager = {
        let instance = MainDatabaseManager()
        instance.observerTerminate()
        return instance
    }()
    
    static var shared: MainDatabaseManager {
        return _shared
        
    }
    
    let allSubject = PassthroughSubject<[Todo],Never>()
    let todosSubject = PassthroughSubject<[Todo],Never>()
    let completedSubject = PassthroughSubject<[Todo],Never>()
    let deletedSubject = PassthroughSubject<[Todo],Never>()
    var subscriptions = [AnyCancellable]()

    var query: String? = nil {
        didSet {
            self.applyQuery()
        }
    }
     
    var todos: (
        all: [Todo],
        todo: [Todo],
        completed: [Todo],
        deleted: [Todo]) = (
            all: Todo.all(),
            todo: Todo.allTodos(),
            completed: Todo.completedTodos(),
            deleted: Todo.softDeletedTodos()
    )
    
    func reload() {
        self.reloadTodos()
    }
    
    func reloadTodos() {
        let all = Todo.all()
        let todos = Todo.allTodos()
        let completeds = Todo.completedTodos()
        let deleteds =  Todo.softDeletedTodos()
        self.todos = (all: all,  todo: todos, completed: completeds, deleted: deleteds)
        self.sendTodos(all: all, todo: todos, completed: completeds, deleted: deleteds)
    }
    
    func applyQuery() {
        guard let _query = self.query?.lowercased() else { self.sendTodos(); return }
        let all = self.todos.all.filter { $0.contains(query: _query) }
        let todos =  self.todos.todo.filter { $0.contains(query: _query)}
        let completeds =  self.todos.completed.filter { $0.contains(query: _query) }
        let deleteds =  self.todos.deleted.filter { $0.contains(query: _query) }
        self.sendTodos(all: all, todo: todos, completed: completeds, deleted: deleteds)
    }
    
    func sendTodos(all: [Todo]? = nil,
                   todo: [Todo]? = nil,
                   completed: [Todo]? = nil,
                   deleted: [Todo]? = nil) {
        
        self.allSubject.send(all == nil ? self.todos.all : all!)
        self.todosSubject.send(todo == nil ? self.todos.todo : todo!)
        self.completedSubject.send(completed == nil ? self.todos.completed : completed!)
        self.deletedSubject.send(deleted == nil ? self.todos.deleted : deleted!)
    }
    
    @objc func save() {
        Todo.save()
    }
    
    func observerTerminate() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.save), name: UIApplication.willTerminateNotification, object: nil)
    }

    
    
}
