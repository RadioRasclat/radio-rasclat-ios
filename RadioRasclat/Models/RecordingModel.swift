//
//  RecordingModel.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 03.12.20.
//

import Foundation

// MARK: - RecordingList
struct RecordingList: Codable {
    let recordings: [Recording]
    
    enum CodingKeys: String, CodingKey {
        case recordings = "results"
    }
}

// MARK: - Result
struct Recording: Codable, Equatable {
    let id: String
    let title, timeStart, timeEnd: String
    let recordingDescription: String
    let audio: String
    let image: String
    
    let show: Show
    let artists: [Artist]
    let genres: [Genre]
    
    var uniqueID = UUID()
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case artists, genres, title, timeStart, timeEnd, show
        case recordingDescription = "description"
        case audio, image
    }
    
    #if DEBUG
    static let example = Recording(id: "123456789", title: "DJ State presents G-Files!", timeStart: "2020-09-06T19:30:00.000Z", timeEnd: "2020-09-06T20:30:00.000Z", recordingDescription: "Hello you all.", audio: "https://s3.eu-central-1.wasabisys.com/prod.radiorasclat.uploads/20201104/audio/radio-rasclat-2-das-intro-ist-ne-lu-ge-.mp3", image: "https://picsum.photos/id/1060/536/354.jpg", show: Show(id: "123456789", title: "G-Files!", description: "Lorem Ipsum", image: "https://picsum.photos/id/1060/536/354.jpg"), artists: [Artist(id: "1", title: "Action", image: "https://picsum.photos/id/1060/536/354.jpg")], genres: [Genre(id: "1", title: "Action")])
    #endif
}

extension Recording {
    static func == (lhs: Recording, rhs: Recording) -> Bool {
        return lhs.id == rhs.id
    }
}
