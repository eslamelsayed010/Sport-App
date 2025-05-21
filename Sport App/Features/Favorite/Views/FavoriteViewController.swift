//
//  FavoriteViewController.swift
//  Sport App
//
//  Created by Macos on 18/05/2025.
//

import UIKit

class FavoriteViewController: UIViewController {
    var leagues: [FavoriteModel] = []
    var presenter: FavoritePresenterProtocol!
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = FavoritePresenter(view: self)
        presenter.fetchFavorites()
        
        self.setupTableView()
        
        tabBar.delegate = self
        if let favItem = tabBar.items?[1] {
            tabBar.selectedItem = favItem
        }

    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: FavoriteTableViewCell.idintefire, bundle: nil), forCellReuseIdentifier: FavoriteTableViewCell.idintefire)
        self.view.backgroundColor = UIColor(red: 26/255.0, green: 20/255.0, blue: 41/255.0, alpha: 1.0)
    }
}

extension FavoriteViewController: UITabBarDelegate{
    func tabBar(_ tabBarView: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBarView.items?.firstIndex(of: item), index == 0 {
            let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
            homeVC.modalTransitionStyle = .crossDissolve
            homeVC.modalPresentationStyle = .fullScreen
            self.present(homeVC, animated: true, completion: nil)
        }
    }
}

extension FavoriteViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.idintefire, for: indexPath) as! FavoriteTableViewCell
        
        let leagueItem = leagues[indexPath.row]
        
        cell.leagueName.text = leagueItem.name
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.frame.height / 2
        cell.leagueImage.loadImage(from: leagueItem.image ?? "laliga")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = LeagueDetailsCollectionView(nibName: "LeagueDetailsCollectionView", bundle: nil)
            detailVC.modalTransitionStyle = .crossDissolve
            detailVC.modalPresentationStyle = .fullScreen
        
          let sport = Sport(rawValue: leagues[indexPath.row].sport ?? "football") ?? .football

        
            detailVC.selectedSport = sport
            detailVC.selectedLeagueId = leagues[indexPath.row].id ?? 0
            detailVC.selectedLeagueName = leagues[indexPath.row].name ?? "D.N"
            detailVC.selectedLeagueImage = leagues[indexPath.row].image ?? "D.N"
        self.present(detailVC, animated: true, completion: nil)
    }
}

extension FavoriteViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showDeleteConfirmation(indexPath: indexPath)
        }
    }
    
    func showDeleteConfirmation(indexPath: IndexPath) {
        let alert = UIAlertController(
            title: "Remove Favorite",
            message: "Are you sure you want to remove this league from favorites?",
            preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.presenter.removeFromFavorites(at: indexPath)
        }))
        
        present(alert, animated: true, completion: nil)
    }
}

extension FavoriteViewController: FavoriteViewProtocol {
    func fetchFavorites(_ favorites: [FavoriteModel]) {
        self.leagues = favorites
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func removeFromFavorite() {
        print("League removed from favorites.")
    }
}
