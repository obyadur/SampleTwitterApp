//
//  TwitterRequest.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import Foundation

protocol TwitterRequest {
    var url: String { get }
    var baseUrl: String { get }
    var endpoint: String { get }
    var method: RequestMethod { get }
    var parameters: Parameters { get }
}

enum TwitterRequestImpl: TwitterRequest {
    
    case fetch(latitude: Double, longitude: Double, distance: String)
    case favourite(tweetId: String)
    case retweet(tweetId: String)
    
    var url: String {
        return baseUrl + endpoint
    }
    
    var baseUrl: String {
        return "https://api.twitter.com/1.1/"
    }
    
    var endpoint: String {
        switch self {
        case .fetch:
            return "search/tweets.json"
        case .favourite:
            return "favorites/create.json"
        case .retweet(let tweetId):
            return "statuses/retweet/" + tweetId + ".json"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .fetch:
            return .GET
        case .favourite:
            return .POST
        case .retweet:
            return .POST
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .fetch(let lat, let long, let dist):
            let geocode = String(lat) + "," + String(long) + "," + dist
            return [Params.Fetch.geocode: geocode, Params.Fetch.resultType: "recent", Params.Fetch.query: " "]
        case .favourite(let tweetId):
            return [Params.id: tweetId]
        case .retweet(let tweetId):
            return [Params.id: tweetId]
        }
    }
    
}


enum Params {
    static let id = "id"
    
    enum Fetch {
        static let geocode = "geocode"
        static let resultType = "result_type"
        static let query = "q"
        static let distance = "1mi"
    }
}


typealias Parameters = [String: Any]

enum RequestMethod: String {
    case GET
    case POST
    case DELETE
}
