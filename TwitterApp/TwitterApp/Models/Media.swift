//
//  Media.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import Foundation

struct Media {
    var id: Int?
    var url: String?
    var videoUrl: String?
    var type: MediaType = .None
    
    init(with json: [String: Any]?) {
        guard let dictionary = json else { return }
        
        id = dictionary[MediaKeys.id] as? Int
        url = dictionary[MediaKeys.url] as? String
        setMediaType(dictionary[MediaKeys.type] as? String, dictionary: dictionary)
    }
    
    private mutating func setMediaType(_ mType: String?, dictionary: [String: Any]) {
        guard let mType = mType else {
            return
        }
        
        if mType == "photo" {
            type = .Photo
        } else if mType == "video" {
            type = .Video
            if let videoInformation = dictionary[MediaKeys.videoUrl] as? [String: AnyObject],
                let variants = videoInformation[MediaKeys.variants] as? [Any], variants.count > 0 {
                let info = variants[0] as? [String: Any]
                videoUrl = info![MediaKeys.variantUrl] as? String
            } else {
                type = .None
            }
        }
    }
}

enum MediaType {
    case None
    case Photo
    case Video
}

private enum MediaKeys {
    static let id = "id"
    static let url = "media_url"
    static let type = "type"
    static let videoUrl = "video_info"
    static let variants = "variants"
    static let variantUrl = "url"
}
