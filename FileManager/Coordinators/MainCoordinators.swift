//
//  MainCoordinators.swift
//  FileManager
//
//  Created by Александр Садыков on 01.11.2023.
//

import UIKit

final class MainCoordinator {
    func startApplication() -> UIViewController {
        
        if UserDefaults.standard.object(forKey: .sizeFile) == nil {
            UserDefaults.standard.set(true, forKey: .sizeFile)
            UserDefaults.standard.set(true, forKey: .sortingFile)
        }
        Settings.sizeFile = UserDefaults.standard.bool(forKey: .sizeFile)
        Settings.sortingFile = UserDefaults.standard.bool(forKey: .sortingFile)
        
        
        let mode: ModeLoginViewController = KeychainService.default.isPasswordEnabled() ? .checkPassword : .createPassword
        let loginViewController = LoginViewController(mode: mode, coordinator: self)
        let loginNavigationController = UINavigationController(rootViewController: loginViewController)
        return loginNavigationController
    }
    
    func openFileManager(navigationController: UINavigationController?){
        let fileManagerController = FileListViewController()
        let fileManagerNavigationController = UINavigationController(rootViewController: fileManagerController)
        fileManagerNavigationController.tabBarItem = UITabBarItem(title: "Documents", image: UIImage(systemName:"filemenu.and.cursorarrow"), tag: 0)

                
        let settigsViewController = SettingsViewController()
        let settingsNavigationController = UINavigationController(rootViewController: settigsViewController)
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.view.backgroundColor = .systemBackground
        tabBarController.viewControllers = [fileManagerNavigationController, settingsNavigationController]
        tabBarController.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(tabBarController, animated: true)

    }
}
