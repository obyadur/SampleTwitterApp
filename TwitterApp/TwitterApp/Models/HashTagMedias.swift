//
//  HashTagMedias.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import Foundation

struct HashTagMedias {
    var medias: [Media] = []
    
    init(with json: [String: Any]?) {
        guard let dictionary = json else { return }
        let tweetStatuses = dictionary[HashTagMediaKeys.statuses] as? [AnyObject]
        for statusDict in tweetStatuses ?? [] {
            if let entities = statusDict[HashTagMediaKeys.entities] as? [String: Any] {
                let allMedia = entities[HashTagMediaKeys.media] as? [Any]
                for aMedia in allMedia ?? [] {
                    print(aMedia)
                    let media = Media(with: aMedia as? [String : Any])
                    if media.type != .None {
                        medias.append(media)
                    }
                }
            }
        }
    }
}

private enum HashTagMediaKeys {
    static let statuses = "statuses"
    static let entities = "entities"
    static let media = "media"
}
