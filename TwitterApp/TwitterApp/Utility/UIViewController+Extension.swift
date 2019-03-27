//
//  UIViewController+Extension.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func viewController<T: UIViewController>(fromStoryboard storyboard: String,
                                                    withId identifier: String? = nil) -> T? {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let viewController: UIViewController?
        if let identifier = identifier {
            viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        } else {
            viewController = storyboard.instantiateInitialViewController()
        }
        return viewController as? T
    }
    
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: Localized.ok, style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
