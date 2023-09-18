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
    
    private var state: WordIsGuessed
    
    var stateChanged: ((WordIsGuessed) -> Void)?
    
    private let feedModel: FeedModel
    
    init(feedModel: FeedModel) {
        self.feedModel = feedModel
        self.state = .unkown
    }
    
    func sendWord(word: String) {
        if feedModel.check(word: word) {
            self.state = .bingo
        } else { self.state = .wrong }
        stateChanged?(self.state)
    }
}
