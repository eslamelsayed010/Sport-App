//
//  LeagueDetailsViewProtocol.swift
//  Sport App
//
//  Created by Macos on 20/05/2025.
//

import Foundation


protocol LeagueDetailsViewProtocol: AnyObject {
    func showUpcomingMatches(_ matches: [Match])
    func showRecentMatches(_ matches: [Match])
    func showLeagueStanding(_ standing: [StandingModel])
    func addToFavorite()
    func removeFromFavorite()
    func showFavoriteStatus(isFavorite: Bool)
    func showError(_ message: String)
}
