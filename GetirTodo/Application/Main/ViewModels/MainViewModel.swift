//
//  MainViewModel.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import UIKit
import Combine

final class MainViewModel {
    
    let model: MainVC
    var subscriptions = [AnyCancellable]()
    @Published var isOnDeleteList: Bool = false

    lazy var pagesCount: Int = self.model.items.count
    lazy var pageTitle: (Int) -> String = { (index: Int) in
        return self.model.items[index].rawValue
    }
    
    lazy var pages: [TableVC] = [
        .make(list: self.model.items[0], coordinator: self.model.coordinator),
        .make(list: self.model.items[1], coordinator: self.model.coordinator),
        .make(list: self.model.items[2], coordinator: self.model.coordinator)
    ]
        
    init(model: MainVC) {
        self.model = model
    }
    
    func bindToggleButtons() {
        self.$isOnDeleteList
            .assign(to: \.shouldToggle, on: self.model.addOrDeleteBtn)
            .store(in: &self.subscriptions)
    }
    
    func setupMenu() {
        self.model.menuView.dataSource = self.model
        self.model.menuView.delegate = self.model
        self.model.menuView.reloadData()
    }
    
    func subscribeSearch() {
        self.model.searchView.$query
            .eraseToAnyPublisher()
            .sink(receiveValue: { Main.shared.database.query = $0 })
            .store(in: &self.subscriptions)
        
    }
    
    func addOrDeleteTapped() {
        self.isOnDeleteList ? self.requestDelete() : self.requestCreate()
    }
    
    func requestCreate() {
        self.model.coordinator?.show(todo: nil)
    }
    
    func requestDelete() {
        Main.shared.database.deleteSoftDeletes()
    }
}
