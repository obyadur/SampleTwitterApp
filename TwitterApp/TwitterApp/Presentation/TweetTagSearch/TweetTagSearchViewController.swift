//
//  TweetTagSearchViewController.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import UIKit

class TweetTagSearchViewController: UIViewController {
    static var temp = 1
    @IBOutlet weak var tagsSearchbar: UISearchBar!
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    
    private var viewModel: TweetTagSearchViewModel!
    
    static func initController() -> TweetTagSearchViewController? {
        if let searchVC = viewController(fromStoryboard: "Main", withId: "TweetTagSearchViewController")
            as? TweetTagSearchViewController {
            searchVC.viewModel = TweetTagSearchViewModelImpl()
            return searchVC
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Localized.TweetTagSearch.navigationTitle
        
        tagsSearchbar.delegate = self
        tagsCollectionView.delegate = self
    }
}

private extension TweetTagSearchViewController {
    
    func fetchHashTags(_ hashTag: String) {
        viewModel.fetchHashTags(hashTag) { [weak self] (success) in
            if success {
                self?.tagsCollectionView.reloadData()
            } else {
                self?.presentAlert(withTitle: Localized.Network.errorTitle, message: Localized.Network.errorMessage.localized)
            }
        }
    }
    
    func presentImageViewController(_ media: Media) {
        if let imageVC = DisplayImageViewController.initController(with: media.url!) {
            self.present(imageVC, animated: true, completion: nil)
        }
    }
    
    func presentPlayerViewController(_ media: Media) {
        if let playerVC = VideoPlayerController.initController(with: media.videoUrl!) {
            self.present(playerVC, animated: true, completion: nil)
        }
    }
}

extension TweetTagSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        fetchHashTags(text)
    }
}

extension TweetTagSearchViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.mediaCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HashTagCell", for: indexPath) as! HashTagCell
        
        let media = viewModel.media(at: indexPath.row)
        cell.config(media!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let media = viewModel.media(at: indexPath.row)
        if media?.type == .Photo {
            presentImageViewController(media!)
        } else if media?.type == .Photo {
            presentPlayerViewController(media!)
        }
    }
}
