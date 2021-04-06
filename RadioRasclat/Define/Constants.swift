//
//  Constants.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 06.04.21.
//

import Foundation

struct Constants {
    static let version: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    static let build: String? = Bundle.main.infoDictionary?["CFBundleVersion"] as? String

    static let appVersionString = "Radio Rasclat iOS Client v\(Constants.version ?? "Undefined") (Build \(Constants.build ?? "Undefined"))"

}
