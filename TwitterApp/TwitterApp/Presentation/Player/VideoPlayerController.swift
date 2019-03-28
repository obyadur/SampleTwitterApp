//
//  VideoPlayerController.swift
//  
//
//  Created by Obyadur Rahman on 3/27/19.
//

import UIKit
import AVKit

class VideoPlayerController: UIViewController {

    @IBOutlet weak var playerContainer: UIView!
    
    private var avPlayer: AVPlayer!
    private let avPlayerController = AVPlayerViewController()
    private var videoUrl: String!
    
    static func initController(with videoUrl: String) -> VideoPlayerController? {
        if let playerVC = viewController(fromStoryboard: "Main", withId: "VideoPlayerController")
            as? VideoPlayerController {
            playerVC.videoUrl = videoUrl
            return playerVC
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        avPlayerController.player?.pause()
    }
    
    override func viewDidLayoutSubviews() {
        avPlayerController.view.frame = CGRect(x: 0, y: 0, width: playerContainer.frame.width, height: playerContainer.frame.height)
    }
    
    func configure() {
        if let videoURL = URL(string: videoUrl) {
            avPlayer = AVPlayer(url: videoURL)
            
            avPlayerController.player = avPlayer
            avPlayerController.showsPlaybackControls = false
            avPlayerController.player?.play()
            self.playerContainer.addSubview(avPlayerController.view)
        }
    }
    
    @IBAction func donePressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
