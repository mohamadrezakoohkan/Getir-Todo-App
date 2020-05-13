//
//  SceneDelegate.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var appDelegate: AppDelegate = .shared

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.startCoordinator(windowScene: windowScene)
    }

    func startCoordinator(windowScene: UIWindowScene) {
        self.appDelegate.coordinator.start()
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = self.appDelegate.coordinator?.navigationController
        self.window = window
        window.makeKeyAndVisible()
    }    
}

