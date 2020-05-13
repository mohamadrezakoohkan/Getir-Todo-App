//
//  TodoVC.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class TodoVC: MainViewController {
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var navbar: TransparentNavigationBar!

    lazy var viewModel = TodoViewModel(model: self, todo: self.todo)
    var todo: Todo?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.setupNavigationBarTitle()
        self.viewModel.setupActionButtons()
    }
    
    @IBAction func backTapped(_ sender: ToggleButton) {
        self.coordinator?.pop()
    }
}
