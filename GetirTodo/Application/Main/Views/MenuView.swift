//
//  MenuView.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class MenuView: SwipeMenuView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setOptions()
    }
    
    func setOptions() {
        var options = SwipeMenuViewOptions()
        options.tabView.itemView.textColor = UIColor.appPurple.withAlphaComponent(0.6)
        options.tabView.itemView.selectedTextColor = UIColor.appPurple
        options.tabView.additionView.backgroundColor = UIColor.appYellow
        options.tabView.additionView.underline.height = 3
        options.tabView.itemView.font = .avenirNextDemiBold
        options.tabView.height = 44
        options.tabView.margin = 10
        self.options = options
        self.reloadData(options: options)
    }
    
    
}
