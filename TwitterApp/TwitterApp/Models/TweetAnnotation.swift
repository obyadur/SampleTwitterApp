//
//  TweetAnnotation.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import Foundation
import MapKit

class TweetAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var tweet: LocationTweet!
    
    init(tweet: LocationTweet) {
        self.tweet = tweet
        self.coordinate = CLLocationCoordinate2D(latitude: (tweet.coordinates?.latitude)!, longitude: (tweet.coordinates?.longitude)!)
    }
}
