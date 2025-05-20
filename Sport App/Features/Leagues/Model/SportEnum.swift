//
//  SportEnum.swift
//  Sport App
//
//  Created by Macos on 19/05/2025.
//

import Foundation

enum Sport: String {
    case football
    case basketball
    case tennis
    case cricket

    var url: String {
        return "https://apiv2.allsportsapi.com/\(self.rawValue)/?met=Leagues&APIkey=\(APIKeys.main)"
    }
}

struct APIKeys {
    static let main = "aae8c2dce2bbb4d5e105f228294a52df200a920529a8d874bdbe080dedce4400"
}
