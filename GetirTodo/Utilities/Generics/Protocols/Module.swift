//
//  Module.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import UIKit
import Combine

public protocol Module {
    
    associatedtype DatabaseType
    associatedtype CoordinatorType

    var storyboard: Storyboard { get }
        
    var database: DatabaseType { get }
    
    var coordinator: CoordinatorType { get }

}
