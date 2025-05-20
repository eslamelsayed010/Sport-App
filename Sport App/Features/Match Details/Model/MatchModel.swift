//
//  MatchModel.swift
//  Sport App
//
//  Created by Macos on 20/05/2025.
//

import Foundation


struct Match: Decodable {
    let event_key: Int?
    let event_date: String?
    let event_time: String?
    let event_home_team: String?
    let event_away_team: String?
    let home_team_logo: String?
    let away_team_logo: String?
    let event_final_result: String?
}

struct MatchesResponse: Decodable {
    var success: Int
    let result: [Match]
}
