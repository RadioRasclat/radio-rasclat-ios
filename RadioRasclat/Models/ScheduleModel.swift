//
//  ScheduleModel.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 28.01.21.
//

import Foundation

// MARK: - Schedule
struct Schedule: Codable {
    let monday: [Day?]
    let tuesday: [Day?]
    let wednesday: [Day?]
    let thursday: [Day?]
    let friday: [Day?]
    let saturday: [Day?]
    let sunday: [Day?]
    let nextmonday: [Day?]
    let nexttuesday: [Day?]
    let nextwednesday: [Day?]
    let nextthursday: [Day?]
    let nextfriday: [Day?]
    let nextsaturday: [Day?]
    let nextsunday: [Day?]

    enum CodingKeys: String, CodingKey {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday, nextmonday, nexttuesday, nextwednesday, nextthursday, nextfriday, nextsaturday, nextsunday
    }
}

// MARK: - Day
struct Day: Codable {
    let name: String
    let startTimestamp, endTimestamp: String
    let description: String?
    let id: Int
    let instanceID, record: Int?
    let url: String?
    let imagePath: String?
    let starts, ends: String
    let instanceDescription: String?

    enum CodingKeys: String, CodingKey {
        case startTimestamp = "start_timestamp"
        case endTimestamp = "end_timestamp"
        case name
        case description = "description"
        case id
        case instanceID = "instance_id"
        case record, url
        case imagePath = "image_path"
        case starts, ends
        case instanceDescription = "instance_description"
    }
}
