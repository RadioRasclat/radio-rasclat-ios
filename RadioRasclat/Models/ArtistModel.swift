//
//  ArtistModel.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 03.12.20.
//

import Foundation

// MARK: - Artists
struct Artists: Codable {
    let artists: [Artist]
}

// MARK: - Artist
struct Artist: Codable {
    let id: String?
    let title: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case image
    }
    
    #if DEBUG
    static let example = Artist(
        id: "123456789",
        title: "Bob Stone",
        image: "https://picsum.photos/id/1060/536/354.jpg"
    )
    #endif
}
