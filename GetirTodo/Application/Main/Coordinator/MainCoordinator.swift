//
//  MainCoordinator.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import UIKit

internal class MainCoordinator: Coordinator {
    
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var presentedViewController: UIViewController?
    
    var viewControllers: [UIViewController] {
        return self.navigationController.viewControllers
    }
    
    var storyboard: Storyboard {
        return Main.shared.storyboard
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        let vc = MainVC.instantiate()
        self.push(vc)
        vc.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func pop() {
        guard let vc = self.viewControllers.last else { return }
        self.pop(vc)
    }
       
    func show(todo: Todo?) {
        let vc = TodoVC.instantiate()
        vc.todo = todo != nil ? todo : .init(context: .init(concurrencyType: .mainQueueConcurrencyType))
        self.push(vc)
    }
    
}

