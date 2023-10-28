//
//  LoginInspector.swift
//  Navigation
//
//  Created by Александр Садыков on 12.09.2023.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
   
    func checkCredentials(email: String, password: String) async throws  -> User {
        var user = User()
        do {
            user = try await CheckerService().checkCredentials(email: email, password: password)
        } catch {
            throw error
        }
        return user
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
