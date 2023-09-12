//
//  Checker.swift
//  Navigation
//
//  Created by Александр Садыков on 12.09.2023.
//

import Foundation

final class Checker {
    private let login = "Sadykov"
    private let password = "123"
   
    static let shared = Checker()
    
    private init() {}
    
    func check(login: String, password: String) -> Bool {
        return self.login == login && self.password == password
    }
}
