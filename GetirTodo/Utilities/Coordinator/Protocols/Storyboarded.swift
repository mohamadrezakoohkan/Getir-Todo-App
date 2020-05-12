//
//  Storyboarded.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import UIKit.UIViewController

public protocol Storyboarded {
    
    static func instantiate(in board: Storyboard) -> Self
    
    func push(from viewController: UIViewController, showBottom hidesBottomBarWhenPushed: Bool, animated: Bool)
    
    func modal(from viewController: UIViewController, animated: Bool)
    
}

public extension Storyboarded where Self: UIViewController {
    
    
    static func instantiate(in board: Storyboard) -> Self {
        let storyboard = board.storyboard
        let id = String(describing: self.self)
        let viewController = storyboard.instantiateViewController(withIdentifier: id)
        guard let storyboardedViewController = viewController as? Self else {
            fatalError("@ERROR \(viewController) is not a Storyboarded")
        }
        return storyboardedViewController
    }
    
    func push(from viewController: UIViewController,
              showBottom hidesBottomBarWhenPushed: Bool = false,
              animated: Bool = true) {
        
        guard let navigationController = viewController.navigationController else {
            fatalError("@ERROR \(viewController) is not a navigation controller")
        }
        navigationController.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        navigationController.pushViewController(self, animated: animated)
    }
    
    func modal(from viewController: UIViewController, animated: Bool = true) {
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        viewController.present(self, animated: animated)
    }
    
}
