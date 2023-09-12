//
//  TestUserService.swift
//  Navigation
//
//  Created by Александр Садыков on 12.09.2023.
//

import UIKit

final class TestUserService: UserService {
       
    var currentUser: User? {
        let user = User()
        user.login = "Sadykov"
        user.fullName = "Александр Садыков"
        user.status = "Вот и лето прошло..."
        user.avatar = UIImage(named: "avatar")!
        return user
    }
    
    func getCurrentUser(_ login: String) -> User? {
        return currentUser
    }
 
    
}
