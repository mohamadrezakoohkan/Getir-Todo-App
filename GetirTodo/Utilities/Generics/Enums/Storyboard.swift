//
//  Storyboard.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import UIKit.UIStoryboard

public enum Storyboard {
    
    case main
    
    var storyboard: UIStoryboard {
        switch self {
        case .main:
            return  .init(name: "Main", bundle: Bundle.main)
        }
    }
}
