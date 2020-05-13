//
//  Keyboard+Appear.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/24/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UIResponder

extension NotificationCenter {
    
    static func observerKeyboardWillShow(_ observer: Any, selector: Selector) {
        `default`.addObserver(observer, selector: selector, name: .keyboardWillShow, object: nil)
    }
    
    static func observerKeyboardWillHide(_ observer: Any, selector: Selector) {
        `default`.addObserver(observer, selector: selector, name: .keyboardWillHide, object: nil)
    }
    
    static func removeKeyboardWillShow(_ observer: Any) {
        `default`.removeObserver(observer, name: .keyboardWillShow, object: nil)
    }
    
    static func removeKeyboardWillHide(_ observer: Any) {
        `default`.removeObserver(observer, name: .keyboardWillShow, object: nil)
    }
}

extension NSNotification.Name {
    
    static var keyboardWillShow: NSNotification.Name {
        return UIResponder.keyboardWillShowNotification
    }
    
    static var keyboardWillHide: NSNotification.Name {
        return UIResponder.keyboardWillHideNotification
    }
}

extension UIView {
    
    func visibleOnKeyboard(_ notification: NSNotification) {
        let key = UIResponder.keyboardFrameEndUserInfoKey
        var accurateY = 0.0
        let _frame = self.superview?.convert(self.frame, from: self.superview) ?? .zero
        accurateY = Double(_frame.origin.y) + Double(_frame.size.height)
        let keyBoardFrame = (notification.userInfo?[key] as? NSValue)?.cgRectValue
        let keyBoardFrameY = keyBoardFrame!.origin.y
        if keyBoardFrameY >= UIScreen.main.bounds.size.height {
            self.keyboardIsHidden()
        } else {
            if accurateY >= Double(keyBoardFrameY) {
                self.superview?.frame.origin.y = -CGFloat(accurateY - Double(keyBoardFrameY)) - 15
            }else{
                self.keyboardIsHidden()
            }
        }
    }
    
    func keyboardIsHidden() {
        self.superview?.frame.origin.y = 0
    }
}

public extension UIResponder {
    
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc private func _trap() {
        Static.responder = self
    }
}

extension UITextField {
    
    @discardableResult
    func datePicker(target: Any, selector: Selector) -> UIDatePicker {
        let picker = UIDatePicker.init()
        picker.datePickerMode = .dateAndTime
        self.inputView = picker
        picker.addTarget(target, action: selector, for: .valueChanged)
        return picker
    }
}
