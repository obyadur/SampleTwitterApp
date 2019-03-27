//
//  TweetMapLayoutView.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import UIKit

class TweetMapLayoutView: UIView {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var text: UILabel!
    
    var tapCompletion: (() -> Void)?
    
    func config(_ annotation: TweetAnnotation) {
        name.text = annotation.tweet.name
        text.text = annotation.tweet.text
    }
    
    @IBAction func pressedDetailButton() {
        tapCompletion?()
    }
}
