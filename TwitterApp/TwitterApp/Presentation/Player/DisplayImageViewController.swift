//
//  DisplayImageViewController.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import UIKit

class DisplayImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    private var imageUrl: String!
    
    static func initController(with imageUrl: String) -> DisplayImageViewController? {
        if let imageVc = viewController(fromStoryboard: "Main", withId: "DisplayImageViewController")
            as? DisplayImageViewController {
            imageVc.imageUrl = imageUrl
            return imageVc
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        imageView.imageFromServerURL(urlString: imageUrl)
    }

    @IBAction func donePressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
