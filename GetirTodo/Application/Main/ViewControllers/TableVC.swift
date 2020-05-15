//
//  TableVC.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

final class TableVC: UITableViewController {
    
    var list: TodoListItem!
    
    lazy var viewModel = TableViewModel(model: self)
    
    weak var coordinator: MainCoordinator?

    @Published var todos = [Todo]() {
        didSet {
            guard self.isViewLoaded else { return }
            self.viewModel.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.setupView()
        self.viewModel.registerCells()
        self.viewModel.subscribeTodos()
        self.viewModel.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.todosCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.todoCell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewModel.cellHeight[indexPath] = cell.frame.size.height
        self.viewModel.bindTodo(cell, indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.estimatedHeight(indexPath)
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return self.viewModel.menu(for: self.todos[indexPath.row])
    }
    
    static func make(list: TodoListItem,
                     coordinator mainCoordinator: MainCoordinator?) -> TableVC {
        
        let controller = TableVC()
        controller.coordinator = mainCoordinator
        controller.todos = list.todos
        controller.list = list
        return controller
    }
    
}
