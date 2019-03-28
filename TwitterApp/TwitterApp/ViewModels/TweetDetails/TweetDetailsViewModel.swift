//
//  TweetDetailsViewModel.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import Foundation

protocol TweetDetailsViewModel {
    var id: String { get }
    var name: String { get }
    var imageUrl: String { get }
    var date: String { get }
    var text: String { get }
    
    func performRetweet(_ id: String, completion: @escaping (Bool) -> Void)
    func makeTweetFavourited(_ id: String, completion: @escaping (Bool) -> Void)
}

class TweetDetailsViewModelImpl: TweetDetailsViewModel {
    private let tweet: LocationTweet!
    private let api: TwitterService!
    
    var id: String {
        guard let id = tweet.id else { return "" }
        return String(id)
    }
    
    var name: String {
        return tweet.name ?? ""
    }
    
    var imageUrl: String {
        return tweet.profileImageUrl ?? ""
    }
    
    var date: String {
        return tweet.createdAt ?? ""
    }
    
    var text: String {
        return tweet.text ?? ""
    }
    
    init(tweet: LocationTweet, api: TwitterService =  TwitterServiceImpl()) {
        self.tweet = tweet
        self.api = api
    }
 
    func performRetweet(_ id: String, completion: @escaping (Bool) -> Void) {
        api.performRetweet(id) { (result) in
            self.process(result, completion: completion)
        }
    }
    
    func makeTweetFavourited(_ id: String, completion: @escaping (Bool) -> Void) {
        api.performTweetFavourited(id) { (result) in
            self.process(result, completion: completion)
        }
    }
    
    private func process(_ result: Result<Bool>, completion: @escaping (Bool) -> Void) {
        switch result {
        case .success:
            completion(true)
        case .failure(let err):
            print("Tweet favourite / retweet failed - \(err.localizedDescription)")
            completion(false)
        }
    }
}
