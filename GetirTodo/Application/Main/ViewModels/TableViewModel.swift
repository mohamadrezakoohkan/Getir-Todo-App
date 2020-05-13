//
//  TableViewModel.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/24/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine
import UIKit

final class TableViewModel {
    
    let model: TableVC
    var subscriptions = [AnyCancellable]()
    var viewSettuped: Bool = false
    var cellHeight: [IndexPath: CGFloat] = [:]

    var todosCount: Int {
        return self.model.todos.count
    }
    
    var todoCell: TodoCell {
        return TodoCell.deque(in: model.tableView!) as! TodoCell
    }
    
    lazy var bindTodo: (UITableViewCell, Int) -> () = { (cell: UITableViewCell,index: Int) in
        TodoCell.bind(to: cell) { $0.todo = self.model.todos[index] }
    }
        
    lazy var estimatedHeight: (IndexPath) -> (CGFloat) = { (index: IndexPath) in
        return self.viewSettuped ? (self.cellHeight[index] ?? 120) : 120
    }
    
    init(model: TableVC) {
        self.model = model
    }
    
    func setupView() {
        self.model.tableView.allowsSelection = false
        self.model.tableView.backgroundColor = .clear
        self.model.tableView.separatorStyle = .none
        self.viewSettuped = true
    }
    
    func registerCells() {
        TodoCell.register(in: self.model.tableView)
    }
    
    func reloadData() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.model.tableView.reloadData()
        }
    }
    
    func subscribeTodos() {
        self.model.list.subject
            .subscribe(on: DispatchQueue.main)
            .sink(receiveValue: { self.model.todos = $0 })
            .store(in: &self.subscriptions)
    }
    
    func menu(for todo: Todo) -> UIContextMenuConfiguration {
        return UIContextMenuConfiguration(identifier: todo.id as NSString?, previewProvider: nil) { _ in
            var actions = [UIAction]()
            if self.model.list != .completed { actions.append(self.completedAction(todo: todo)) }
            if self.model.list != .deleted { actions.append(self.deleteAction(todo: todo)) }
            return UIMenu(title: "", children: actions)
        }
    }
    
    private func deleteAction(todo: Todo) -> UIAction{
        return UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
            todo.softDelete()
        }
    }
    
    private func completedAction(todo: Todo) -> UIAction{
        return UIAction(title: "Compelete", image: UIImage(systemName: "checkmark")) { _ in
            todo.complete()
        }
    }
}
