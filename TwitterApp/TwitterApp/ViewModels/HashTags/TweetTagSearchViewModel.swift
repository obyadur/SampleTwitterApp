//
//  TweetTagSearchViewModel.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import Foundation

protocol TweetTagSearchViewModel: class {
    var mediaCount: Int { get }
    func media(at index: Int) -> Media?
    func fetchHashTags(_ hashTags: String, completion: @escaping (Bool) -> Void)
}

class TweetTagSearchViewModelImpl: TweetTagSearchViewModel {
    
    private var allMedias: [Media] = []
    private let api: TwitterService!
    
    var mediaCount: Int {
        return allMedias.count
    }
    
    init(api: TwitterService =  TwitterServiceImpl()) {
        self.api = api
    }
    
    func media(at index: Int) -> Media? {
        if allMedias.count > 0 && index > -1 && index < allMedias.count {
            return allMedias[index]
        }
        return nil
    }
    
    func fetchHashTags(_ hashTags: String, completion: @escaping (Bool) -> Void) {
        api.fetchHashTags(hashTags) { (result) in
            switch result {
            case .success(let response):
                self.allMedias = response.medias
                print("Total Medias: \(self.allMedias.count)")
                completion(true)
            case .failure(let err):
                print("Hash Tag fetch failed - \(err.localizedDescription)")
                completion(false)
            }
        }
    }
}
