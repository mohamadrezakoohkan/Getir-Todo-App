//
//  Singleton.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

public protocol Singleton {
    
    /// Should refer to constant private single instance to make a Thread-safe initialization
    ///
    static var shared: Self { get }
}
