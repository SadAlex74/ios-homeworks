//
//  CheckerService.swift
//  Navigation
//
//  Created by Александр Садыков on 28.10.2023.
//

import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String) async throws -> User
}

final class CheckerService: CheckerServiceProtocol {
    func checkCredentials(email: String, password: String) async throws -> User {
        let user = TestUserService().user
        do {
            user.fullName = try await loginUser(email: email, password: password)
            return user
        } catch {
            throw error
        }
    }
    
    
    private func loginUser(email: String, password: String) async throws -> String {
        var displayName = ""
        do {
            let answer = try await Auth.auth().signIn(withEmail: email, password: password)
            displayName = answer.user.displayName ?? "Anonimus"
            
        } catch {
            print(error.localizedDescription)
            let error2:NSError = error as NSError
            if error2.code == 17999 {
                do {
                    let newUser = try await createUser(email: email, password: password)
                    return newUser
                } catch {
                    throw error
                }
            }
            throw error
        }
        return displayName
    }
    
    private func createUser(email: String, password: String) async throws -> String {
        var displayName = ""
        do {
            let answer = try await Auth.auth().createUser(withEmail: email, password: password)
            displayName = answer.user.displayName ?? "Anonimus"
        } catch {
            throw error
        }
        return displayName
    }
}
