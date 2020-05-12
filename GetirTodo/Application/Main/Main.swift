//
//  Main.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

final class Main: Singleton, Module {    
    
    private static let _shared: Main = Main()
    static var shared: Main {
        return Main._shared
    }
    
    var storyBoard: Storyboard {
        return .main
    }

//    var coordinator
}
