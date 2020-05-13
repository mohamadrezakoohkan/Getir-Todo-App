//
//  TodoVC.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

final class TodoVC: MainViewController {
    
    @IBOutlet weak var navbar: TransparentNavigationBar!
    @IBOutlet weak var nameIcon: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameHint: UILabel!
    @IBOutlet weak var dateHint: UILabel!
    @IBOutlet weak var aboutHint: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dueDateField: UITextField!
    @IBOutlet weak var dueDateImg: UIImageView!
    
    lazy var viewModel = TodoViewModel(model: self, todo: self.todo)
    lazy var snack: SnackView = SnackView(parent: self.navigationController!.view)
    let errorPublisher: PassthroughSubject<String?,Never> = .init()
    let successPublisher: PassthroughSubject<String?,Never> = .init()
    var todo: Todo? 

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.observerNameField()
        self.viewModel.observerKeyboard()
        self.viewModel.setupErrorAndSuccess()
        self.viewModel.setupNavigationBarTitle()
        self.viewModel.setupActionButtons()
        self.viewModel.setupHints()
        self.viewModel.setupFields()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.viewModel.endEditing()
    }
    
    @IBAction func backTapped(_ sender: ToggleButton) {
        self.coordinator?.pop()
    }
    
    @IBAction func createOrUpdateTapped(_ sender: UIButton) {
        self.viewModel.updateOrCreateAction()
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        self.viewModel.deleteAction()
    }
    
    @IBAction func completeTapped(_ sender: UIButton) {
        self.viewModel.completeAction()
    }
}

extension TodoVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.viewModel.endEditing()
        return true
    }
}

extension TodoVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.viewModel.textViewBegin(textView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.viewModel.textViewEnd(textView)
    }
}
