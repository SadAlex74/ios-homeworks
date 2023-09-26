//
//  LoginInspector.swift
//  Navigation
//
//  Created by Александр Садыков on 12.09.2023.
//

import Foundation


struct LoginInspector: LoginViewControllerDelegate {
    
    private func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    private func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
                                   : Character("")
    }

    private func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }
    
    private func generatePassword(lenght: Int, array: [String]) -> String {
        var password = ""
        for _ in (1...lenght) {
            password.append(characterAt(index: Int.random(in: 0...(array.count - 1)), array ))
        }
        return password
    }
    
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
    }
    
    func generateAndBruteForcePassword( completion: @escaping (String) -> Void) {
        let passwordLenght = 4
        let array = String().printable.map { String($0) }
        var password = ""
        
        Checker.shared.setPassword(generatePassword(lenght: passwordLenght, array: array))
        
        let workItem = DispatchWorkItem {
            while !Checker.shared.checkPassword(password) {
                password = generateBruteForce(password, fromArray: array)
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async(execute: workItem)
        
        workItem.notify(queue: .main) { completion(password) }
    }
    
}

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters }
 


    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
