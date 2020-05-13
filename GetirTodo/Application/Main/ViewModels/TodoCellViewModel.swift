//
//  TodoCellViewModel.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/24/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

final class TodoCellViewModel {
    
    let model: TodoCell
    var todo: Todo?
    
    init(model: TodoCell, todo: Todo?) {
        self.model = model
        self.todo = todo
    }
    
    func feed() {
        let status = self.todo?.durationStatus
        self.model.titleLbl.text = self.todo?.title
        self.model.aboutLbl.text = self.todo?.about
        self.model.timeLbl.textColor = status?.color
        self.model.timeLbl.text = self.todo?.time
        self.model.monthDayLbl.text = self.todo?.dayInMonth
    }
    
    func setupGestures() {
        self.model.cellView.addGestureRecognizer(self.model.tapGesture)
    }
    
    func tapped() {
        guard let parent = self.model.parentViewController as? TableVC else { return }
        parent.coordinator?.show(todo: self.todo!)
    }
}
