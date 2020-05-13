//
//  MainVC.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class MainVC: MainViewController {

    @IBOutlet weak var addOrDeleteBtn: ToggleButton!
    @IBOutlet weak var menuView: MenuView!
    @IBOutlet weak var searchView: SearchView!
    
    lazy var viewModel = MainViewModel(model: self)
    lazy var items: [TodoListItem] = [.todo,.completed,.deleted]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.bindToggleButtons()
        self.viewModel.setupMenu()
        self.viewModel.subscribeSearch()
    }
    
    
    @IBAction func addOrDeleteTapped(_ sender: ToggleButton) {
        self.viewModel.addOrDeleteTapped()
    }
    
    @IBAction func editTapped(_ sender: ToggleButton) {
        sender.toggle()
    }
}

extension MainVC: SwipeMenuViewDelegate,SwipeMenuViewDataSource {
    
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return self.viewModel.pagesCount
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return self.viewModel.pageTitle(index)
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        return self.viewModel.pages[index]
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        self.viewModel.isOnDeleteList = toIndex == 2
    }
}
