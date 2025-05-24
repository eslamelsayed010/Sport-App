//
//  TennisMatchModel.swift
//  Sport App
//
//  Created by Macos on 24/05/2025.
//

import Foundation

struct TennisMatch: Decodable {
    let event_key: Int?
    let event_date: String?
    let event_time: String?
    let event_first_player: String?
    let event_second_player: String?
    let event_first_player_logo: String?
    let event_second_player_logo: String?
    let event_final_result: String?
    let scores: [TennisScore]?
}

struct TennisScore: Decodable {
    let score_first: String?
    let score_second: String?
    let score_set: String?
}


struct TennisMatchesResponse: Decodable {
    var success: Int
    let result: [TennisMatch]
}
