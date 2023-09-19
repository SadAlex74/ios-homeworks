//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Александр Садыков on 19.09.2023.
//

import UIKit

final class FeedCoordinator {
    func push(navigationController: UINavigationController? , title: String) {
        let postViewController = PostViewController(coordinator: self)
        postViewController.titlePost = title
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    func presentInfo(navigationController: UINavigationController?){
        let infoViewController = InfoViewController()
        infoViewController.modalTransitionStyle = .flipHorizontal
        infoViewController.modalPresentationStyle = .pageSheet
        navigationController?.present(infoViewController, animated: true)
    }
}
