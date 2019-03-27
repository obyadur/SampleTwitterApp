//
//  Localized.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import Foundation

struct Localized {
    static let ok = "OK".localized
    static let cancel = "Cancel".localized
    static let retry = "Retry".localized
}

extension Localized {
    enum Network {
        static let errorTitle = "Oops".localized
        static let errorMessage = "Downloading neary by tweets failed. Please try again.".localized
    }
}
