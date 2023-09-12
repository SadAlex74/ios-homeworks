//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Александр Садыков on 12.09.2023.
//

import Foundation

final class CurrentUserService: UserService {
    
    private var _currentUser: User?
    var currentUser: User? {
        return _currentUser
    }
    
    init(login: String){
        self._currentUser = getCurrentUser(login)
    }
    
    func getCurrentUser(_ login: String) -> User? {
        // какой-то код для проверки логина и получения пользователя, но пока других пользователей нет возвращаем nil
        // возможно вместо двух классов можно использовать один, в нем в подставлять тестового юзера или искать реального
        return nil
    }
    
}
