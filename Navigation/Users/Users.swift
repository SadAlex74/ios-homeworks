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
    func getCurrentUser (_ login: String) -> User?
}
