//
//  TeamModel.swift
//  Sport App
//
//  Created by Macos on 20/05/2025.
//

import Foundation

struct TeamModel: Codable {
    let team_name: String?
    let team_logo: String?
    let players: [PlayerModel]?
}


