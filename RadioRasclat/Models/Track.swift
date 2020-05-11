//
//  Track.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 11.05.20.
//  Copyright © 2020 Domenik Toefflinger. All rights reserved.
//

import UIKit

struct Track {
    var artist: String?
    var name: String?
    
    var image: UIImage?
    
    init(artist: String? = nil, name: String? = nil, image: UIImage? = nil) {
        self.name = name
        self.artist = artist
        self.image = image
    }
}
