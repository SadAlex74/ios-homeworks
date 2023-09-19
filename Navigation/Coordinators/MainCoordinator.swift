//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Александр Садыков on 19.09.2023.
//

import UIKit

final class MainCoordinator {
    func startApplication() -> UIViewController {
        let feedCoordinator = FeedCoordinator()
        let feedNavigationController = UINavigationController(rootViewController: FeedViewController(coordinator: feedCoordinator))
        feedNavigationController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName:"text.bubble"), tag: 0)
        
        let profileCoordinator = ProfileCoordinator()
        let loginViewController = LogInViewController(coordinator: profileCoordinator)
        loginViewController.loginDelegate = MyLoginFactory().makeLoginInspector()
        
        let profileNavigationController = UINavigationController(rootViewController: loginViewController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.text.rectangle.fill"), tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.view.backgroundColor = .systemBackground
        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
        return tabBarController
    }
}
