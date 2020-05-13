//
//  AppDelegate.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate, Singleton {
    
    private static let _shared = UIApplication.shared.delegate as! AppDelegate
    static var shared: AppDelegate {
        return ._shared
    }
    
    var window: UIWindow?
    var coordinator: MainCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setupCoordinator()
        return true
    }
    
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GetirTodo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func setupCoordinator() {
        let navigationController: UINavigationController = MainNavigationController()
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        self.coordinator = mainCoordinator
    }

    
}

