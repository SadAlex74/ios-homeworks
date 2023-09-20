//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Александр Садыков on 19.09.2023.
//

import UIKit

final class ProfileCoordinator {
    func openProfile(navigationController: UINavigationController?, user: User){
        let profileViewController = ProfileViewController(user: user)
        navigationController?.pushViewController(profileViewController, animated: true)

    }
}
