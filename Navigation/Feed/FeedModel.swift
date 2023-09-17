//
//  FeedModel.swift
//  Navigation
//
//  Created by Александр Садыков on 17.09.2023.
//

import Foundation

final class FeedModel {
    private let secretWord = "Secret"
    static let shared = FeedModel()
    
    private init() {}
    
    func check(word: String) -> Bool {
        return word == secretWord
    }
}
