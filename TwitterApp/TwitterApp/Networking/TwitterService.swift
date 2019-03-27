//
//  TwitterService.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import Foundation
import TwitterKit
import CoreLocation

protocol TwitterService {
    func fetchTweets(_ location: CLLocationCoordinate2D, completion: @escaping (Result<Tweets>) -> Void)
    func performTweetFavourited(_ id: String, completion: @escaping (Result<Bool>) -> Void)
    func performRetweet(_ id: String, completion: @escaping (Result<Bool>) -> Void)
}

class TwitterServiceImpl: TwitterService {
    private let client: TWTRAPIClient
    
    init(client: TWTRAPIClient = TWTRAPIClient()) {
        self.client = client
    }
    
    func fetchTweets(_ location: CLLocationCoordinate2D, completion: @escaping (Result<Tweets>) -> Void) {
        let request = TwitterRequestImpl.fetch(latitude: location.latitude, longitude: location.longitude, distance: Params.Fetch.distance)
        perform(request: request) { (data, error) in
            if let error = error {
                print("Request failed: \(error.localizedDescription)")
                completion(Result.failure(error))
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    completion(Result.success(Tweets(with: json)))
                } catch {
                    print("JSON Parsing failed.")
                    completion(Result.failure(APIError.jsonConversionFailure))
                }
            }
        }
    }

    func performTweetFavourited(_ id: String, completion: @escaping (Result<Bool>) -> Void) {
        let request = TwitterRequestImpl.favourite(tweetId: id)
        perform(request: request) { (data, error) in
            if let error = error {
                print("Request failed: \(error.localizedDescription)")
                completion(Result.failure(error))
            } else {
                completion(Result.success(true))
            }
        }
    }
    
    func performRetweet(_ id: String, completion: @escaping (Result<Bool>) -> Void) {
        let request = TwitterRequestImpl.retweet(tweetId: id)
        perform(request: request) { (data, error) in
            if let error = error {
                print("Request failed: \(error.localizedDescription)")
                completion(Result.failure(error))
            } else {
                completion(Result.success(true))
            }
        }
    }
}

private extension TwitterServiceImpl {
    func perform(request: TwitterRequest, completion: @escaping (Data?, APIError?) -> Void) {
        var requestError : NSError?
        
        let request = client.urlRequest(withMethod: request.method.rawValue, urlString: request.url, parameters: request.parameters, error: &requestError)
        guard requestError == nil else {
            completion(nil, .requestFailed)
            return
        }
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    completion(data, nil)
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}
