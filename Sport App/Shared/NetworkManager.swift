//
//  NetworkManager.swift
//  Sport App
//
//  Created by Macos on 19/05/2025.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private let requester: NetworkRequesting

     init(requester: NetworkRequesting = AlamofireNetworkRequester()) {
        self.requester = requester
    }

    func fetchLeagues(for sport: Sport, completion: @escaping (Result<[League], Error>) -> Void) {
        let url = sport.url
        requester.request(url, responseType: LeagueResponse.self) { result in
            switch result {
            case .success(let leagues):
                completion(.success(leagues.result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchFixtures(for sport: Sport, leagueId: Int, from: String, to: String, completion: @escaping (Result<[Match], Error>) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sport.rawValue)/?met=Fixtures&APIkey=\(APIKeys.main)&from=\(from)&to=\(to)&leagueId=\(leagueId)"
        requester.request(url, responseType: MatchesResponse.self) { result in
            switch result {
            case .success(let matchResponse):
                completion(.success(matchResponse.result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchLeagueStanding(for sport: Sport, leagueId: Int, completion: @escaping (Result<[StandingModel], Error>) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sport.rawValue)/?&met=Standings&leagueId=\(leagueId)&APIkey=\(APIKeys.main)"
        requester.request(url, responseType: StandingsResult.self) { result in
            switch result {
            case .success(let standingsResponse):
                completion(.success(standingsResponse.result.total))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchTeamPlayers(for sport: Sport, teamId: Int, completion: @escaping (Result<[TeamModel], Error>) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sport.rawValue)/?&met=Teams&teamId=\(teamId)&APIkey=\(APIKeys.main)"
        requester.request(url, responseType: TeamResult.self) { result in
            switch result {
            case .success(let teamResponse):
                completion(.success(teamResponse.result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
