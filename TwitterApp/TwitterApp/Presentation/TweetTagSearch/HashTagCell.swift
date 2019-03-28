//
//  HashTagCell.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import UIKit

class HashTagCell: UICollectionViewCell {
    
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var playIcon: UIImageView!
    
    func config(_ media: Media) {
        mediaImageView.imageFromServerURL(urlString: media.url!)
        playIcon.isHidden = media.type == .Photo
    }
}
