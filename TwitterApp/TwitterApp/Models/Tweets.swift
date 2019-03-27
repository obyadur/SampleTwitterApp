//
//  Tweets.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import Foundation

struct Tweets {
    var tweets: [Tweet] = []
    
    init(with json: [String: Any]?) {
        guard let dictionary = json else { return }
        let tweetStatuses = dictionary[TweetsKeys.statuses] as? [Any]
        for statusDict in tweetStatuses! {
            let status = Tweet(with: statusDict as? [String : Any])
            if status.coordinates?.latitude != 0.0 && status.coordinates?.longitude != 0.0 {
                tweets.append(status)
            }
        }
    }
}

private enum TweetsKeys {
    static let statuses = "statuses"
}
