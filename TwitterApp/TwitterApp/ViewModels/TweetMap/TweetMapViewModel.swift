//
//  TweetMapViewModel.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import Foundation
import CoreLocation

protocol TweetMapViewModel: class {
    var tweets: [Tweet] { get }
    func fetchTweets(with location: CLLocationCoordinate2D, completion: @escaping (Bool) -> Void)
}

class TweetMapViewModelImpl: TweetMapViewModel {
    
    private var allTweets: [Tweet] = []
    private let api: TwitterService!
    
    var tweets: [Tweet] {
        return allTweets
    }
    
    init(api: TwitterService =  TwitterServiceImpl()) {
        self.api = api
    }
    
    func fetchTweets(with location: CLLocationCoordinate2D, completion: @escaping (Bool) -> Void) {
        api.fetchTweets(location) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.allTweets = response.tweets
                print("Total tweets: \(self?.allTweets.count)")
                completion(true)
            case .failure(let err):
                print("Tweets fetch failed - \(err.localizedDescription)")
                completion(false)
            }
        }
    }
}
