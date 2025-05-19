//
//  LeaguesViewController.swift
//  Sport App
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class LeaguesViewController: UIViewController {
    @IBAction func arrowBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tableView: UITableView!
    let leagues:[LeagueModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: LeagueTableViewCell.idintefire, bundle: nil), forCellReuseIdentifier: LeagueTableViewCell.idintefire)
    }
}

extension LeaguesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeagueTableViewCell.idintefire, for: indexPath) as!LeagueTableViewCell
        
        cell.leagueName.text = "League Table View Cell"
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.frame.height / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = LeagueDetailsCollectionView(nibName: "LeagueDetailsCollectionView", bundle: nil)
        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.modalPresentationStyle = .fullScreen
        self.present(detailVC, animated: true, completion: nil)
    }
}

