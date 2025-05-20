//
//  ViewProtocol.swift
//  Sport App
//
//  Created by Macos on 19/05/2025.
//

import Foundation

protocol LeaguesViewProtocol: AnyObject {
    func showLeagues(_ leagues: [League])
    func showError(_ message: String)
}
