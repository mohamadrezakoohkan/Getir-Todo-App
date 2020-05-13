//
//  TransparentNavigationBar.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

class TransparentNavigationBar: UINavigationBar {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clear()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.clear()
    }
    
    func clear() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        self.backgroundColor = .clear
    }
    
}
