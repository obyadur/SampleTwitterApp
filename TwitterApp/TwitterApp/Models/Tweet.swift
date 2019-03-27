//
//  Tweet.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import Foundation

struct Tweet {
    var id: Int?
    var name: String?
    var text: String?
    var profileImageUrl: String?
    var coordinates: Coordinates?
    var createdAt: String?
    
    init(with json: [String: Any]?) {
        guard let dictionary = json else { return }
        
        id = dictionary[TweetKeys.id] as? Int
        name = getName(dictionary[TweetKeys.user] as? [String : Any])
        text = dictionary[TweetKeys.text] as? String
        
        let coordinatesArray = getCoordinates(dictionary[TweetKeys.coordinates] as? [String: Any])
        coordinates = Coordinates(with: coordinatesArray)
        
        profileImageUrl = getProfileImage(dictionary[TweetKeys.user] as? [String : Any])
        createdAt = dictionary[TweetKeys.created_at] as? String
    }
    
    private func getName(_ json: [String: Any]?) -> String? {
        guard let dictionary = json else { return nil}
        return dictionary[TweetKeys.name] as? String
    }
    
    private func getProfileImage(_ json: [String: Any]?) -> String? {
        guard let dictionary = json else { return nil}
        return dictionary[TweetKeys.profile_image_url] as? String
    }
    
    private func getCoordinates(_ json: [String: Any]?) -> [Double]? {
        guard let dictionary = json, let coordinates = dictionary[TweetKeys.coordinates] as? [Double] else { return nil}
        return coordinates
    }
}

private enum TweetKeys {
    static let id = "id"
    static let text = "text"
    static let user = "user"
    static let created_at = "created_at"
    static let name = "name"
    static let profile_image_url = "profile_image_url"
    static let coordinates = "coordinates"
}
