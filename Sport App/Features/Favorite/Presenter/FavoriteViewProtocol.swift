//
//  FavoriteViewProtocol.swift
//  Sport App
//
//  Created by Macos on 21/05/2025.
//

import Foundation

protocol FavoriteViewProtocol: AnyObject{
    func fetchFavorites(_ favorites: [FavoriteModel])
    func removeFromFavorite()
}
