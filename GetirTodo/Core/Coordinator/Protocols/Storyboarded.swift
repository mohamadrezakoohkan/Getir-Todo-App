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
    
    func push(from viewController: UIViewController,
              showBottom hidesBottomBarWhenPushed: Bool,
              animated: Bool)
    
    func pop(animated: Bool)
    
    func modal(from viewController: UIViewController, animated: Bool)
    
}

public extension Storyboarded where Self: UIViewController {
    
    
    static func instantiate(in board: Storyboard) -> Self {
        let storyboard = board.storyboard
        let id = String(describing: self)
        let viewController = storyboard.instantiateViewController(withIdentifier: id)
        guard let storyboardedViewController = viewController as? Self else {
            fatalError("@ERROR \(viewController) is not a Storyboarded")
        }
        return storyboardedViewController
    }
    
    func push(from viewController: UIViewController,
              showBottom hidesBottomBarWhenPushed: Bool = true,
              animated: Bool = true) {
        
        var navigationController: UINavigationController? = nil
        
        if let navigation = viewController as? UINavigationController {
            navigationController = navigation
        }else{
            guard let navigation = viewController.navigationController else {
                fatalError("@ERROR \(viewController) is not a navigation controller")
            }
            navigationController = navigation
        }
        navigationController!.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        navigationController!.pushViewController(self, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    func modal(from viewController: UIViewController, animated: Bool = true) {
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        viewController.present(self, animated: animated)
    }
    
}
