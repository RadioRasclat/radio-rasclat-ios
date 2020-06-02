//
//  BroadcastsApi.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 15.05.20.
//  Copyright © 2020 Domenik Toefflinger. All rights reserved.
//

import Foundation

struct Broadcasts: Decodable {
    let title: String
    let description: String
    let image: String
    let audio: String
}
