//
//  TweetDetailsViewController.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    private var viewModel: TweetDetailsViewModel!
    
    static func initController(_ tweet: Tweet) -> TweetDetailsViewController? {
        if let tweetDetailsVC = viewController(fromStoryboard: "Main", withId: "TweetDetailsViewController")
            as? TweetDetailsViewController {
            tweetDetailsVC.viewModel = TweetDetailsViewModelImpl(tweet: tweet)
            return tweetDetailsVC
        }
        return nil
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Localized.TweetDetails.navigationTitle
        setup()
    }
}

private extension TweetDetailsViewController {
    
    private func setup() {
        profileImageView.imageFromServerURL(urlString: self.viewModel.imageUrl)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        textLabel.text = viewModel.text
    }
}

extension TweetDetailsViewController {
    
    @IBAction func pressedFavouriteButton() {
        viewModel.makeTweetFavourited(viewModel.id) { (success) in
            let title = success ? Localized.TweetDetails.favouriteSuccessTitle : Localized.TweetDetails.favouriteErrorTitle
            let message = success ? Localized.TweetDetails.favouriteSuccessMessage : Localized.TweetDetails.favouriteErrorMessage
            self.presentAlert(withTitle: title, message: message)
        }
    }
    
    @IBAction func pressedReTweetButton() {
        viewModel.performRetweet(viewModel.id) { (success) in
            let title = success ? Localized.TweetDetails.retweetSuccessTitle : Localized.TweetDetails.retweetErrorTitle
            let message = success ? Localized.TweetDetails.retweetSuccessMessage : Localized.TweetDetails.retweetErrorMessage
            self.presentAlert(withTitle: title, message: message)
        }
    }
}
