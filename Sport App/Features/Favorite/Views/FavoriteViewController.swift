//
//  FavoriteViewController.swift
//  Sport App
//
//  Created by Macos on 18/05/2025.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: FavoriteTableViewCell.idintefire, bundle: nil), forCellReuseIdentifier: FavoriteTableViewCell.idintefire)
        self.view.backgroundColor = UIColor(red: 26/255.0, green: 20/255.0, blue: 41/255.0, alpha: 1.0)
        
        
        tabBar.delegate = self
        if let favItem = tabBar.items?[1] {
            tabBar.selectedItem = favItem
        }

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

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.idintefire, for: indexPath) as! FavoriteTableViewCell
        
        cell.leagueName.text = "League Table View Cell"
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.frame.height / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
