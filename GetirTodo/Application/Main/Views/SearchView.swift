//
//  SearchView.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

final class SearchView: UIView {

    @IBOutlet weak var searchViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var textFieldStackWidth: NSLayoutConstraint!
    @IBOutlet weak var textFieldStack: UIStackView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!

    private (set) var isOpen = false
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer()
    let closeSearchWidth: CGFloat = 145
    let openSearchWidth: CGFloat = UIScreen.main.bounds.width - 94
    let openSearchTrailing: CGFloat = 64
    let closeSearchTrailing: CGFloat = 10
    let animationDuration: TimeInterval = 0.3
    
    @Published var query: String? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGestureRecognizer(self.tap)
        self.observerCancel()
        self.observerTap()
        self.observerSearchField()
    }

    func observerCancel() {
        self.cancelButton.addTarget(self, action: #selector(self.cancel), for: .touchUpInside)
    }
    
    func observerTap() {
        self.tap.addTarget(self, action: #selector(self.open))
    }
    
    func observerSearchField() {
        self.textField.addTarget(self, action: #selector(self.search), for: .editingChanged)
        self.textField.addTarget(self, action: #selector(self.open), for: .editingDidBegin)
        self.textField.addTarget(self, action: #selector(self.close), for: .editingDidEnd)
    }
    
    @objc func cancelTapped() {
        self.cancel()
    }
    
    @objc func viewTapped() {
        self.open()
    }
    
    @objc func open() {
        guard !self.isOpen else { return }
        self.isOpen = true
        self.textField.becomeFirstResponder()
        UIView.animate(withDuration: self.animationDuration) {
            self.textFieldStackWidth.constant = self.openSearchWidth
            self.searchViewTrailing.constant = self.openSearchTrailing
            self.superview?.layoutIfNeeded()
            self.layoutIfNeeded()
        }
    }
    
    @objc func close() {
        guard self.isOpen else { return }
        self.textField.resignFirstResponder()
        guard self.textField.text?.isEmpty == true else { return }
        self.isOpen = false
        UIView.animate(withDuration: self.animationDuration) {
            self.textFieldStackWidth.constant = self.closeSearchWidth
            self.searchViewTrailing.constant = self.closeSearchTrailing
            self.superview?.layoutIfNeeded()
            self.layoutIfNeeded()
        }
    }
    
    @objc func cancel() {
        self.textField.text = nil
        self.search()
        self.close()
    }
    
    @objc func search() {
        self.query = self.textField.text
    }

}

extension SearchView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.close()
        return true
    }
}
