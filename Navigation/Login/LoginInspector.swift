//
//  LoginInspector.swift
//  Navigation
//
//  Created by Александр Садыков on 12.09.2023.
//

import Foundation


struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
    }

}
