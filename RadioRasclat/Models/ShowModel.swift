//
//  ShowModel.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 03.12.20.
//

import Foundation

// MARK: - Show
struct Show: Codable, Equatable {
    let id: String
    let title: String
    let description: String
    let image: String
        
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case description
        case image
    }
    
    #if DEBUG
    static let example = Show(
        id: "123456789",
        title: "DJ State presents G-Files!",
        description: "Hello you all.",
        image: "https://picsum.photos/id/1060/500/500.jpg"
    )
    #endif
}
