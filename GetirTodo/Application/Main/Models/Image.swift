//
//  Image.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/24/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

enum Image: String {
    
    case trashFill = "trash.fill"
    
    case plus = "plus.app.fill"
    
    case trash
    
    case checkmark
    
    var image: UIImage {
        return UIImage(systemName: self.rawValue)!
    }
}
