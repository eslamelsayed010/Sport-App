//
//  StandingsResult.swift
//  Sport App
//
//  Created by Macos on 20/05/2025.
//

import Foundation

struct StandingsResult: Codable{
    let result: Total
}

struct Total: Codable{
    let total: [StandingModel]
}
