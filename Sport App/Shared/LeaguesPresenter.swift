//
//  LeaguesPresenter.swift
//  Sport App
//
//  Created by Macos on 19/05/2025.
//

import Foundation


protocol LeaguesPresenterProtocol {
    func fetchLeagues(for sport: Sport)
}

class LeaguesPresenter {
    weak var view: LeaguesViewProtocol?

    init(view: LeaguesViewProtocol) {
        self.view = view
    }
}

extension LeaguesPresenter: LeaguesPresenterProtocol {
    func fetchLeagues(for sport: Sport) {
        print("Fetching leagues for sport: \(sport)")
        
        NetworkManager.shared.fetchLeagues(for: sport) { [weak self] result in
            switch result {
            case .success(let leagues):
                self?.view?.showLeagues(leagues)
            case .failure(let error):
                //print("Failed to fetch leagues: \(error)")
                self?.view?.showError(error.localizedDescription)
            }
        }
    }

}
