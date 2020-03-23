//
//  Recording.swift
//  Recording
//
//  Created by Domenik Toefflinger on 6/21/19.
//  Copyright © 2020 Domenik Toefflinger. All rights reserved.
//

import SwiftUI

struct Recording: Hashable, Codable, Identifiable {
    var id: String
    var title: String
    var description: String
    var image: URL
    var audio: URL
    var show: ShowTitle
    var timeStart: String
    var timeEnd: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case image
        case audio
        case show
        case timeStart
        case timeEnd
    }
}

struct ShowTitle:  Hashable, Codable {
    var id: String
    var title: String
    var image: URL
}
