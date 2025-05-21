//
//  FavoritePresenter.swift
//  Sport App
//
//  Created by Macos on 21/05/2025.
//

import Foundation
import UIKit
import CoreData

protocol FavoritePresenterProtocol {
    func fetchFavorites()
    func removeFromFavorites(at indexPath: IndexPath)
}


class FavoritePresenter: FavoritePresenterProtocol {
    
    weak var view: FavoriteViewProtocol?
    var favorites: [FavoriteModel] = []
    
    init(view: FavoriteViewProtocol) {
        self.view = view
    }
    
    func fetchFavorites() {
        favorites.removeAll()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueCoreData")

        do {
            let results = try context.fetch(fetchRequest)
            for item in results {
                let model = FavoriteModel(
                    id: item.value(forKey: "id") as? Int,
                    name: item.value(forKey: "name") as? String,
                    image: item.value(forKey: "image") as? String,
                    sport: item.value(forKey: "sport") as? String
                )
                favorites.append(model)
            }
            view?.fetchFavorites(favorites)
        } catch {
            print("Failed to fetch favorites: \(error.localizedDescription)")
        }
    }
    
    func removeFromFavorites(at indexPath: IndexPath) {
        guard indexPath.row < favorites.count else { return }
        let leagueToDelete = favorites[indexPath.row]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LeagueCoreData")
        fetchRequest.predicate = NSPredicate(format: "id == %d", leagueToDelete.id ?? 0)

        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                if let obj = object as? NSManagedObject {
                    context.delete(obj)
                }
            }
            try context.save()
            favorites.remove(at: indexPath.row)
            view?.fetchFavorites(favorites)
            view?.removeFromFavorite()
        } catch {
            print("Error deleting favorite: \(error.localizedDescription)")
        }
    }
}

