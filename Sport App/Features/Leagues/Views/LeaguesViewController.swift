//
//  LeaguesViewController.swift
//  Sport App
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class LeaguesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    let leagues:[LeagueModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension LeaguesViewController: UITableViewDelegate{}
extension LeaguesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        return nil
    }
}

