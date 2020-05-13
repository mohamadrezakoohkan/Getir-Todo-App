//
//  Main.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

final class Main: Singleton, Module {
    
    typealias DatabaseType = MainDatabaseManager
    typealias CoordinatorType = MainCoordinator

    private static let _shared: Main = Main()
    static var shared: Main {
        return Main._shared
    }
    
    var storyboard: Storyboard {
        return .main
    }
    
    var database: MainDatabaseManager {
        return .shared
    }

    var coordinator: MainCoordinator {
        return AppDelegate.shared.coordinator!
    }
    
    var string: MainStrings {
        return .shared
    }

}
