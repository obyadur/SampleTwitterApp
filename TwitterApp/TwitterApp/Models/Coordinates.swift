//
//  Coordinates.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import Foundation

struct Coordinates {
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    init(with coordinates: [Double]?) {
        guard let cord = coordinates, cord.count == 2 else { return }
        longitude = cord[0]
        latitude = cord[1]
    }
}
