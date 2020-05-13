//
//  Instantiable.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

public protocol Instantiable {
        
    static func instantiate() -> Self
    
}
