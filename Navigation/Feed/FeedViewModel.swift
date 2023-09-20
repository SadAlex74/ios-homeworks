//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Александр Садыков on 18.09.2023.
//

import Foundation

final class FeedViewModel {
    enum WordIsGuessed {
        case bingo
        case wrong
        case unkown
    }
    
    private var state: WordIsGuessed = .unkown
    
    var stateChanged: ((WordIsGuessed) -> Void)?
    
    private let feedModel = FeedModel()
       
    func sendWord(word: String) {
        state = feedModel.check(word: word) ?  .bingo : .wrong
        stateChanged?(state)
    }
}
