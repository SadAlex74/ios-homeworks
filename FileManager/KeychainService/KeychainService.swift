//
//  KeychainService.swift
//  FileManager
//
//  Created by Александр Садыков on 04.11.2023.
//

import Foundation
import KeychainSwift

protocol KeychainServiceProtocol {
    func isPasswordEnabled() -> Bool
    func writePassword(password: String)
    func isPasswordCorrect(password: String) -> Bool
}


final class KeychainService: KeychainServiceProtocol {
    static let `default` = KeychainService()
    private init(){}
    
    func isPasswordEnabled() -> Bool {
        true
    }
    
    func writePassword(password: String) {
        
    }
    
    func isPasswordCorrect(password: String) -> Bool {
        true
    }
    
    
}
