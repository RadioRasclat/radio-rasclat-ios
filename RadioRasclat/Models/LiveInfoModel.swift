//
//  LiveInfoModel.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 25.01.21.
//

import Foundation

// MARK: - LiveInfo
struct LiveInfo: Codable {
    let name, description: String
        let url: String
        let imagePath: String
        let starts, ends: String

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case url
        case imagePath = "image_path"
        case starts, ends
    }
    
    static let example = LiveInfo(
        name: "G!-Files Vol.6 — Pure Bliss w/ DJ Pregnant b2b DJ State",
        description: "Pure Bliss is fully packed with two and half hours of vogue Grime, UK- & Bass-influenced Wave & Hardwave music.",
        url: "https://radio-rasclat.com/shows/g-files-by-dj-state",
        imagePath: "https://station.radio-rasclat.com/api/show-logo?id=331",
        starts: "2021-01-25 16:00:00",
        ends: "2021-01-25 18:00:00"
    )
}
