//
//  TeamProtocol.swift
//  Sport App
//
//  Created by Macos on 20/05/2025.
//

import Foundation

protocol TeamViewProtocol: AnyObject {
    func showTeam(_ Team: [TeamModel])
    func showError(_ message: String)
}
