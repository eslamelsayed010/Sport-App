//
//  LeaguesViewController.swift
//  Sport App
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class LeaguesViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var leagues: [League] = []
    var selectedSport: Sport!
    var presenter: LeaguesPresenterProtocol!

    // MARK: - Actions
    @IBAction func arrowBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = LeaguesPresenter(view: self)
        presenter.fetchLeagues(for: selectedSport)

        setupTableView()
    }

    // MARK: - Setup
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: LeagueTableViewCell.idintefire, bundle: nil),
                           forCellReuseIdentifier: LeagueTableViewCell.idintefire)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension LeaguesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeagueTableViewCell.idintefire, for: indexPath) as! LeagueTableViewCell
        let league = leagues[indexPath.row]
        cell.configure(with: league)
        return cell
    }



    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = LeagueDetailsCollectionView(nibName: "LeagueDetailsCollectionView", bundle: nil)
            detailVC.modalTransitionStyle = .crossDissolve
            detailVC.modalPresentationStyle = .fullScreen
            
            detailVC.selectedSport = selectedSport
            detailVC.selectedLeagueId = leagues[indexPath.row].leagueKey
        self.present(detailVC, animated: true, completion: nil)
    }
}

// MARK: - LeaguesViewProtocol
extension LeaguesViewController: LeaguesViewProtocol {
    func showLeagues(_ leagues: [League]) {
        self.leagues = leagues
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showError(_ message: String) {
        print("Error: \(message)")
    }
}
