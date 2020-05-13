//
//  MainViewController.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

public class MainViewController: StoryboardedViewController, Instantiable {
    
    final weak var coordinator: MainCoordinator?
    
    static var module: Main {
        return Main.shared
    }
}

public extension Instantiable where Self: MainViewController {
    
    static func instantiate() -> Self {
        let vc = Self.instantiate(in: Self.module.storyboard)
        vc.coordinator = Self.module.coordinator
        return vc
    }
}
