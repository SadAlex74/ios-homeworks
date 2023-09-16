//
//  Users.swift
//  Navigation
//
//  Created by Александр Садыков on 12.09.2023.
//

import UIKit

class User {
    var login: String = ""
    var fullName: String = ""
    var status: String = ""
    var avatar: UIImage = UIImage()
}

protocol UserService {
    var user: User { get set }
    func getCurrentUser(_ login: String) -> User?
}

extension UserService {
    func getCurrentUser(_ login: String) -> User? {
        return login == user.login ? user : nil
    }
}
