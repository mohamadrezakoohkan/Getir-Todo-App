//
//  TodoViewModel.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/24/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

final class TodoViewModel {
    
    let model: TodoVC
    var todo: Todo?
    
    var isEdit: Bool {
        return self.todo != nil
    }
    
    var isComplete: Bool {
        return self.todo?.completed == true
    }
    
    var isDelete: Bool {
        return self.todo?.softDeleted == true
    }
    
    var string: MainStrings {
        return Main.shared.string
    }
    
    init(model: TodoVC, todo: Todo?) {
        self.model = model
        self.todo = todo
    }
    
    func setupNavigationBarTitle() {
        self.model.navbar.topItem?.title = isEdit ? string.editTask : string.createTask
    }
    
    func setupActionButtons() {
        self.model.deleteBtn.isHidden = self.isDelete || !isEdit
        self.model.completeBtn.isHidden = self.isComplete || !isEdit
        self.model.createBtn.setTitle(isEdit ? self.string.update : self.string.create , for: .normal)
    }
    
}
