//
//  LeagueDetailsPresenter.swift
//  Sport App
//
//  Created by Macos on 20/05/2025.
//

import Foundation

protocol LeagueDetailsPresenterProtocol {
    func fetchMatches()
}


class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {
    
    weak var view: LeagueDetailsViewProtocol?
    let sport: Sport
    let leagueId: Int
    
    init(view: LeagueDetailsViewProtocol, sport: Sport, leagueId: Int) {
        self.view = view
        self.sport = sport
        self.leagueId = leagueId
    }
    
    func fetchMatches() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let today = Date()
        let twoMonthsLater = Calendar.current.date(byAdding: .month, value: 2, to: today)!
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -300, to: today)!
        
        let fromUpcoming = formatter.string(from: today)
        let toUpcoming = formatter.string(from: twoMonthsLater)
        
        let fromRecent = formatter.string(from: sevenDaysAgo)
        let toRecent = formatter.string(from: today)
        
        let eventDateFormatter = DateFormatter()
        eventDateFormatter.dateFormat = "yyyy-MM-dd"
        eventDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        NetworkManager.shared.fetchFixtures(for: sport, leagueId: leagueId, from: fromUpcoming, to: toUpcoming) { [weak self] result in
            switch result {
            case .success(let matches):
                let sorted = matches.sorted {
                    guard
                        let date1String = $0.event_date,
                        let date2String = $1.event_date,
                        let date1 = eventDateFormatter.date(from: date1String),
                        let date2 = eventDateFormatter.date(from: date2String)
                    else {
                        return false
                    }
                    return date1 < date2
                }
                
                if let nearestMatch = sorted.first {
                    self?.view?.showUpcomingMatches([nearestMatch])
                } else {
                    self?.view?.showUpcomingMatches([])
                }
                
            case .failure(let error):
                self?.view?.showError("Upcoming matches fetch failed: \(error.localizedDescription)")
            }
        }
        
        NetworkManager.shared.fetchFixtures(for: sport, leagueId: leagueId, from: fromRecent, to: toRecent) { [weak self] result in
            switch result {
            case .success(let matches):
                let sorted = matches.sorted {
                    guard let date1 = $0.event_date, let date2 = $1.event_date,
                          let d1 = eventDateFormatter.date(from: date1),
                          let d2 = eventDateFormatter.date(from: date2) else { return false }
                    return d1 > d2
                }
                
                let last15 = Array(sorted.prefix(15))
                self?.view?.showRecentMatches(last15)
                
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
        
        NetworkManager.shared.fetchLeagueStanding(for: sport, leagueId: leagueId) { [weak self] result in
            switch result {
            case .success(let standings):
                self?.view?.showLeagueStanding(standings)
                
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
        
    }
}
