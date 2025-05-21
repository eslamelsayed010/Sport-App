//
//  LeagueDetailsPresenter.swift
//  Sport App
//
//  Created by Macos on 20/05/2025.
//

import Foundation

protocol TeamPresenterProtocol {
    func fetchTeams()
}


class TeamPresenter: TeamPresenterProtocol {
    
    weak var view: TeamViewProtocol?
    let sport: Sport
    let teamId: Int
    
    init(view: TeamViewProtocol, sport: Sport, teamId: Int) {
        self.view = view
        self.sport = sport
        self.teamId = teamId
    }
    
    func fetchTeams() {
        NetworkManager.shared.fetchTeamPlayers(for: sport, teamId: teamId) { [weak self] result in
            switch result {
            case .success(let team):
                self?.view?.showTeam(team)
                
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
        
    }
}
