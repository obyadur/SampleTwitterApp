//
//  TweetDetailsStrings.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import Foundation

extension Localized {
    enum TweetDetails {
        static let navigationTitle = "Tweet Details".localized
        
        static let favouriteErrorTitle = "Sorry!".localized
        static let favouriteSuccessTitle = "Tweet favourite posting failed. Please try again.".localized
        static let favouriteErrorMessage = "Yahoo!".localized
        static let favouriteSuccessMessage = "You have successfully favourited this tweet.".localized
        
        static let retweetErrorTitle = "Oops Sorry!".localized
        static let retweetSuccessTitle = "Re-Tweeting failed. Please try again.".localized
        static let retweetErrorMessage = "Hurrah!".localized
        static let retweetSuccessMessage = "You have successfully re-tweet this tweet.".localized
    }
}
