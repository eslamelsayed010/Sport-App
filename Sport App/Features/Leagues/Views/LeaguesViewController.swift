//
//  LeaguesViewController.swift
//  Sport App
//
//  Created by Macos on 15/05/2025.
//

import UIKit
import NVActivityIndicatorView

class LeaguesViewController: UIViewController {
    var filteredLeagues: [League] = []
    var isSearching: Bool = false

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    var customIndicator: NVActivityIndicatorView!
    
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
        setupCustomLoader()
        
        presenter = LeaguesPresenter(view: self)
        customIndicator.startAnimating()
        presenter.fetchLeagues(for: selectedSport)
        
        setupTableView()
    }

    // MARK: - Setup
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: LeagueTableViewCell.idintefire, bundle: nil),
                           forCellReuseIdentifier: LeagueTableViewCell.idintefire)

        if let headerView = Bundle.main.loadNibNamed("HeaderSearchCollectionReusableView", owner: nil, options: nil)?.first as? HeaderSearchCollectionReusableView {
            
            headerView.searchBar.delegate = self
            headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
            
            tableView.tableHeaderView = headerView
        }
    }
    
    func setupCustomLoader() {
        let size: CGFloat = 50
        customIndicator = NVActivityIndicatorView(frame: CGRect(x: (view.frame.width - size)/2,y: (view.frame.height - size)/2,width: size,height: size),
                                                  type: .ballRotate,
                                                  color: .white,
                                                  padding: 0)
        view.addSubview(customIndicator)
    }


}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension LeaguesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredLeagues.count : leagues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeagueTableViewCell.idintefire, for: indexPath) as! LeagueTableViewCell
        let league = isSearching ? filteredLeagues[indexPath.row] : leagues[indexPath.row]
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
            detailVC.selectedLeagueName = leagues[indexPath.row].leagueName ?? "D.N"
            detailVC.selectedLeagueImage = leagues[indexPath.row].leagueLogo ?? "D.N"
        self.present(detailVC, animated: true, completion: nil)
    }
}

// MARK: - LeaguesViewProtocol
extension LeaguesViewController: LeaguesViewProtocol {
    func showLeagues(_ leagues: [League]) {
        DispatchQueue.main.async {
            self.customIndicator.stopAnimating()
            self.leagues = leagues
            self.filteredLeagues = leagues
            self.tableView.reloadData()
        }
    }

    func showError(_ message: String) {
        DispatchQueue.main.async {
            self.customIndicator.stopAnimating()
        }
        print("Error: \(message)")
    }
}

extension LeaguesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredLeagues = leagues
        } else {
            isSearching = true
            filteredLeagues = leagues.filter {
                $0.leagueName?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

