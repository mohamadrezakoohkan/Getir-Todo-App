//
//  SnackView.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/24/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

final class SnackView: UILabel {
    
    private var drawInset: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
    private (set) var height: CGFloat = 44
    private let animationDuration: TimeInterval = 0.3
    private (set) var duration: TimeInterval = 3

    var leading: NSLayoutConstraint?
    var trailing: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    override func drawText(in rect: CGRect) {
        rect.inset(by: self.drawInset)
        super.drawText(in: rect)
    }
    
    init(parent: UIView, frame: CGRect = .zero, color: UIColor = .appRed, text: String = "", duration: TimeInterval = 3) {
        super.init(frame: frame)
        self.setupView()
        self.duration = duration
        self.text = text
        self.backgroundColor = color
        parent.addSubview(self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        self.isUserInteractionEnabled = false
        self.alpha = 0
        self.textColor = .white
        self.textAlignment = .center
        self.font = .avenirNextDemiBold
        self.layer.cornerRadius = 0
        self.layer.masksToBounds = true
    }
    
    func layout() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            guard let parent = self.superview else { return }
            let safeArea = parent.safeAreaInsets.bottom
            if safeArea != 0 { self.font = self.font.withSize(17) }
            self.height += parent.safeAreaInsets.bottom
            self.translatesAutoresizingMaskIntoConstraints = false
            self.leading = self.leadingAnchor.constraint(equalTo: parent.leadingAnchor)
            self.trailing = self.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
            self.bottom = self.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
            self.heightConstraint = self.heightAnchor.constraint(equalToConstant: self.height)
            [self.leading,self.trailing,self.bottom,self.heightConstraint].forEach { $0?.isActive = true }
            self.hide()
        }
    }
    
    func show() {
        UIView.animate(withDuration: self.animationDuration) {
            self.alpha = 1
            self.bottom?.constant = 0
            self.superview?.layoutIfNeeded()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + self.duration) {
            self.hide()
        }
    }
    
    func hide() {
        UIView.animate(withDuration: self.animationDuration) {
            self.alpha = 0
            self.bottom?.constant = self.height
            self.superview?.layoutIfNeeded()
        }
    }
    
    func observerError(_ subject: PassthroughSubject<String?,Never>,
                       cancelBy subs: inout [AnyCancellable]) {
        subject
            .subscribe(on: DispatchQueue.main)
            .sink(receiveValue: {
                self.text = $0
                self.backgroundColor = .appRed
                self.show()
            })
            .store(in: &subs)
    }
    
    func observerSuccess(_ subject: PassthroughSubject<String?,Never>,
                         cancelBy subs: inout [AnyCancellable]) {
        subject
            .subscribe(on: DispatchQueue.main)
            .sink(receiveValue: {
                self.text = $0
                self.backgroundColor = .appGreen
                self.show()
            })
            .store(in: &subs)

    }
}
