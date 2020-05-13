//
//  DurationStatus.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/24/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import UIKit

enum DurationStatus {

    case soon
    
    case over
    
    case normal
    
    
    var color: UIColor {
        switch self {
        case .normal:
            return .appGreen
        case .over:
            return .appRed
        case .soon:
            return .appYellow
        }
    }
    
    var text: String {
        switch self {
        case .normal:
            return "NORMAL"
        case .over:
            return "OVER"
        case .soon:
            return "SOON"
        }
    }
}
