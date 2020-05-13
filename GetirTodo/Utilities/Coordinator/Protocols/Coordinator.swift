//
//  Coordinator.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import UIKit.UINavigationController

public protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    
    var navigationController: UINavigationController { get set }
    
    var presentedViewController: UIViewController? { get set }

    func start()
    
    func push(_ viewController: UIViewController & Storyboarded)
    
    func pop(_ viewController: UIViewController, animated: Bool)
    
    func dismiss()

}

public extension Coordinator {
    
    func push(_ viewController: UIViewController & Storyboarded) {
        viewController.push(from: self.navigationController)
    }
    
    func pop(_ viewController: UIViewController, animated: Bool = true) {
        viewController.navigationController?.popViewController(animated: animated)
    }
    
    func dismiss() {
        self.presentedViewController?.dismiss(animated: true, completion: nil)
        self.presentedViewController = nil
    }
    
    
}
