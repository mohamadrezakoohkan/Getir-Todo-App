//
//  TodoViewModel.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/24/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import UIKit
import Combine

final class TodoViewModel {
    
    let model: TodoVC
    var todo: Todo?
    var subscriptions = [AnyCancellable]()

    var selectedName: String? = nil {
        didSet {
            self.setupName(self.selectedName)
        }
    }
    
    var selectedDate: Date? = nil {
        didSet {
            self.setDueDate(self.selectedDate)
        }
    }
    
    var selectedAbout: String? = nil {
        didSet {
            self.setAbout(self.selectedAbout)
        }
    }
    
    var isEdit: Bool {
        return self.todo?.id != nil
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
    
    lazy var dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter
    }()
    
    
    init(model: TodoVC, todo: Todo?) {
        self.model = model
        self.todo = todo
    }
    
    func setupErrorAndSuccess() {
        self.model.snack.layout()
        self.model.snack.observerError(self.model.errorPublisher, cancelBy: &self.subscriptions)
        self.model.snack.observerSuccess(self.model.successPublisher, cancelBy: &self.subscriptions)
    }
    
    func setupNavigationBarTitle() {
        self.model.navbar.topItem?.title = isEdit ? string.editTask : string.createTask
    }
    
    func setupActionButtons() {
        self.model.deleteBtn.isHidden = self.isDelete || !isEdit
        self.model.completeBtn.isHidden = self.isComplete || !isEdit
        self.model.createBtn.setTitle(isEdit ? self.string.update : self.string.create , for: .normal)
    }
    
    func setupHints() {
        self.model.nameHint.text = self.isEdit ? self.string.editTaskName : self.string.createTaskName
        self.model.dateHint.text = self.isEdit ? self.string.editTaskDate : self.string.createTaskDate
        self.model.aboutHint.text = self.isEdit ? self.string.editTaskDescription : self.string.createTaskDescription
    }
    
    func setupFields() {
        self.model.dueDateField.datePicker(target: self, selector: #selector(self.dateChanged(_:)))
        self.model.dueDateField.addTarget(self, action: #selector(self.dateBegin(_:)), for: .editingDidBegin)
        self.selectedName = self.todo?.title
        self.selectedAbout = self.todo?.about
        self.selectedDate = self.todo?.dueDate
    }
    
    func setupName(_ nameStr: String?) {
        if let name = nameStr, !name.isEmpty {
            self.model.nameField.text = name;
            self.model.nameIcon.alpha = 1
        }
    }
    
    func observerNameField() {
        self.model.nameField.addTarget(self, action: #selector(self.nameChanged(_:)), for: .editingChanged)
        self.model.nameField.addTarget(self, action: #selector(self.nameEnd(_:)), for: .editingDidEnd)
    }
    
    func setAbout(_ aboutStr: String?) {
        if let about = aboutStr, !about.isEmpty {
            self.model.textView.text = about;
            self.model.textView.textColor = .black
        }
    }
    
    func setDueDate(_ date: Date?) {
        if let dueDate = date {
            self.model.dueDateField.text = self.dateFormat.string(from: dueDate)
            self.model.dueDateImg.alpha = 1
        }
    }
    
    func updateOrCreateAction() {
        self.endEditing()
        guard let name = self.selectedName else {
            self.model.errorPublisher.send(self.string.errorNameInvalid)
            return
        }
        guard let dueDate = self.selectedDate else {
            self.model.errorPublisher.send(self.string.errorDateInvalid)
            return
        }
        guard let about = self.selectedAbout else {
            self.model.errorPublisher.send(self.string.errorDescriptionInvalid)
            return
        }
        self.todo?.title = name
        self.todo?.dueDate = dueDate
        self.todo?.about = about
        
        self.isEdit
            ? self.todo?.update()
            : self.todo?.create()
        self.isEdit
            ? self.model.successPublisher.send(self.string.updatedMessage)
            : self.model.successPublisher.send(self.string.createdMessage)
        self.model.coordinator?.pop()
    }
    
    func deleteAction() {
        self.endEditing()
        self.todo?.softDelete()
        self.model.successPublisher.send(self.string.deletedMessage)
        self.model.coordinator?.pop()
    }
    
    func completeAction() {
        self.endEditing()
        self.todo?.complete()
        self.model.successPublisher.send(self.string.completedMessage)
        self.model.coordinator?.pop()
    }
    
    func observerKeyboard() {
        NotificationCenter.observerKeyboardWillShow(self, selector: #selector(self.keyboardWillShow(_:)))
        NotificationCenter.observerKeyboardWillHide(self, selector: #selector(self.keyboardWillHide(_:)))
    }
    
    func removeObserverKeyboard() {
        NotificationCenter.removeKeyboardWillHide(self)
        NotificationCenter.removeKeyboardWillShow(self)
    }
    
    func textViewBegin(_ txtView: UITextView) {
        let isPlaceholderedText = txtView.text == self.string.textViewPlaceholder
        let isPlaceholderedColor = txtView.textColor == .appPlaceholder
        guard (isPlaceholderedText && isPlaceholderedColor) else { return}
        txtView.text = ""
        txtView.textColor = .black
    }
    
    func textViewEnd(_ txtView: UITextView) {
        self.selectedAbout = txtView.text
        guard txtView.text.isEmpty else {
            return
        }
        txtView.text = self.string.textViewPlaceholder
        txtView.textColor = .appPlaceholder
        
    }
    
    func endEditing() {
        self.model.view.endEditing(true)
    }
    
    @objc func nameChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        UIView.animate(withDuration: 0.3) {
            self.selectedName = text
        }
        
    }
    
    @objc func nameEnd(_ sender: UITextField) {
        let text = sender.text ?? ""
        if text == "" {
            UIView.animate(withDuration: 0.3) {
                self.model.nameIcon.alpha = 0.5
            }
        }
        
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        UIView.animate(withDuration: 0.3) {
            self.selectedDate = sender.date
        }
    }
    
    @objc func dateBegin(_ sender: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.selectedDate = Date()
        }
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        let mostFirstResponder = UIResponder.currentFirst()
        if mostFirstResponder === self.model.textView {
            self.model.stackView.visibleOnKeyboard(notification)
        }else if mostFirstResponder === self.model.dueDateField {
            self.model.stackView.visibleOnKeyboard(notification)
        }
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard UIResponder.currentFirst() === self.model.textView else {
            self.model.stackView.keyboardIsHidden()
            return
        }
        self.model.stackView.visibleOnKeyboard(notification)
    }

    deinit {
        self.removeObserverKeyboard()
    }
    
}
