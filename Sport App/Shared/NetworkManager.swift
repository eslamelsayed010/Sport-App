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
    private init() {}

    func fetchLeagues(for sport: Sport, completion: @escaping (Result<[League], Error>) -> Void) {
        let url = sport.url
           AF.request(url).responseDecodable(of: LeagueResponse.self) { response in
               switch response.result {
               case .success(let leagues):
                   completion(.success(leagues.result))
               case .failure(let error):
                   print("Error: \(error)")
               }
           }
    }
    
    
    func fetchFixtures(for sport: Sport, leagueId: Int, from: String, to: String, completion: @escaping (Result<[Match], Error>) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sport.rawValue)/?met=Fixtures&APIkey=\(APIKeys.main)&from=\(from)&to=\(to)&leagueId=\(leagueId)"
        
        AF.request(url).responseDecodable(of: MatchesResponse.self) { response in
            switch response.result {
            case .success(let matchResponse):
                completion(.success(matchResponse.result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
}
