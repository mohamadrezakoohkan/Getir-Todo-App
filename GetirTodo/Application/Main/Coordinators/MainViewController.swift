//
//  MainViewController.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

class MainViewController: StoryboardedViewController {
    
    final var module: Main {
        return Main.shared
    }
    
    final var board: Storyboard {
        return self.module.storyBoard
    }
}
