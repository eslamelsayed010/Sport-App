//
//  LeagueDetailsPresenter.swift
//  Sport App
//
//  Created by Macos on 20/05/2025.
//

import Foundation
import UIKit
import CoreData

protocol LeagueDetailsPresenterProtocol {
    func fetchMatches()
    func addToFavorites()
    func removeFromFavorites()
    func checkIfFavorite()
}


class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {
    
    weak var view: LeagueDetailsViewProtocol?
    let sport: Sport
    let leagueId: Int
    var leagueName: String?
    var leagueImage: String?
    var isFavorite: Bool = false

    init(view: LeagueDetailsViewProtocol, sport: Sport, leagueId: Int, leagueName: String?, leagueImage: String?) {
        self.view = view
        self.sport = sport
        self.leagueId = leagueId
        self.leagueName = leagueName
        self.leagueImage = leagueImage
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
        
        if sport.isTennis {
            NetworkManager.shared.fetchTennisFixtures(leagueId: leagueId, from: fromUpcoming, to: toUpcoming) { [weak self] result in
                switch result {
                case .success(let matches):
                    let sorted = matches.sorted {
                        guard let d1 = $0.event_date, let d2 = $1.event_date else { return false }
                        return d1 < d2
                    }
                    if let nearest = sorted.first {
                        self?.view?.showUpcomingMatches([nearest.toMatch()])
                    } else {
                        self?.view?.showUpcomingMatches([])
                    }
                case .failure(let error):
                    self?.view?.showError("Upcoming Tennis matches fetch failed: \(error.localizedDescription)")
                }
            }
            
            NetworkManager.shared.fetchTennisFixtures(leagueId: leagueId, from: fromRecent, to: toRecent) { [weak self] result in
                switch result {
                case .success(let matches):
                    let sorted = matches.sorted {
                        guard let d1 = $0.event_date, let d2 = $1.event_date else { return false }
                        return d1 > d2
                    }
                    let last15 = Array(sorted.prefix(15)).map { $0.toMatch() }
                    self?.view?.showRecentMatches(last15)
                case .failure(let error):
                    self?.view?.showError("Recent Tennis matches fetch failed: \(error.localizedDescription)")
                }
            }
        } else {
            NetworkManager.shared.fetchFixtures(for: sport, leagueId: leagueId, from: fromUpcoming, to: toUpcoming) { [weak self] result in
                switch result {
                case .success(let matches):
                    let sorted = matches.sorted {
                        guard
                            let date1String = $0.event_date,
                            let date2String = $1.event_date,
                            let date1 = formatter.date(from: date1String),
                            let date2 = formatter.date(from: date2String)
                        else { return false }
                        return date1 < date2
                    }
                    self?.view?.showUpcomingMatches(Array(sorted.prefix(1)))
                case .failure(let error):
                    self?.view?.showError("Upcoming matches fetch failed: \(error.localizedDescription)")
                }
            }
            
            NetworkManager.shared.fetchFixtures(for: sport, leagueId: leagueId, from: fromRecent, to: toRecent) { [weak self] result in
                switch result {
                case .success(let matches):
                    let sorted = matches.sorted {
                        guard let date1 = $0.event_date, let date2 = $1.event_date,
                              let d1 = formatter.date(from: date1),
                              let d2 = formatter.date(from: date2) else { return false }
                        return d1 > d2
                    }
                    self?.view?.showRecentMatches(Array(sorted.prefix(15)))
                case .failure(let error):
                    self?.view?.showError("Recent matches fetch failed: \(error.localizedDescription)")
                }
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

    
    
    func addToFavorites() {
           guard let leagueName = leagueName, let leagueImage = leagueImage else { return }

           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           let context = appDelegate.persistentContainer.viewContext

           let entity = NSEntityDescription.entity(forEntityName: "LeagueCoreData", in: context)
           let league = NSManagedObject(entity: entity!, insertInto: context)

           league.setValue(leagueId, forKey: "id")
           league.setValue(leagueName, forKey: "name")
           league.setValue(leagueImage, forKey: "image")
           league.setValue(sport.rawValue, forKey: "sport")

           do {
               try context.save()
               isFavorite = true
               view?.addToFavorite()
           } catch {
               view?.showError("Failed to add to favorites")
           }
       }

       func removeFromFavorites() {
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           let context = appDelegate.persistentContainer.viewContext

           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LeagueCoreData")
           fetchRequest.predicate = NSPredicate(format: "id == %d", leagueId)

           do {
               let results = try context.fetch(fetchRequest)
               for object in results {
                   if let objectToDelete = object as? NSManagedObject {
                       context.delete(objectToDelete)
                   }
               }
               try context.save()
               isFavorite = false
               view?.removeFromFavorite()
           } catch {
               view?.showError("Failed to remove from favorites")
           }
       }

    func checkIfFavorite() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LeagueCoreData")
        fetchRequest.predicate = NSPredicate(format: "id == %d", leagueId)

        do {
            let results = try context.fetch(fetchRequest)
            isFavorite = !results.isEmpty
            view?.showFavoriteStatus(isFavorite: isFavorite)
        } catch {
            isFavorite = false
            view?.showFavoriteStatus(isFavorite: false)
            view?.showError("Failed to check favorite status")
        }
    }

    
}


extension TennisMatch {
    func toMatch() -> Match {
        return Match(
            event_key: self.event_key,
            event_date: self.event_date,
            event_time: self.event_time,
            event_home_team: self.event_first_player,
            event_away_team: self.event_second_player,
            home_team_logo: self.event_final_result,
            away_team_logo: nil,
            event_final_result: nil)
    }
}
