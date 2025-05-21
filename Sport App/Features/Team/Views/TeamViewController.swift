//
//  TeamViewController.swift
//  Sport App
//
//  Created by Macos on 16/05/2025.
//

import UIKit

class TeamViewController: UIViewController {
    var teamId: Int!
    var selectedSport: Sport!
    
    var teamModel: TeamModel?
    var presenter: TeamPresenterProtocol!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupCollectionView()
        
        presenter = TeamPresenter(view: self, sport: selectedSport, teamId: teamId)
        presenter.fetchTeams()
    }
    
    func setupLayout() {
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 20, right: 16)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10

        let screenWidth = UIScreen.main.bounds.width
        let totalHorizontalPadding: CGFloat = 16 + 16
        layout.itemSize = CGSize(width: screenWidth - totalHorizontalPadding, height: 100)
    }

    
    func setupCollectionView(){
        collectionView?.collectionViewLayout = layout
        collectionView?.register(TeamCollectionViewCell.nib(), forCellWithReuseIdentifier: TeamCollectionViewCell.identifier)
        
        collectionView?.register(UINib(nibName: "HeaderTeamCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderTeamCollectionReusableView.identifier)

        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.backgroundColor = UIColor(red: 26/255.0, green: 20/255.0, blue: 41/255.0, alpha: 1.0)
    }

}


extension TeamViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamModel?.players?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCollectionViewCell.identifier, for: indexPath) as! TeamCollectionViewCell
        
        let player = teamModel?.players?[indexPath.row]
        
        cell.playerImage.layer.cornerRadius = cell.playerImage.frame.height / 2
        cell.playerImage.loadImage(from: player?.player_image ?? "noImage")
        cell.playerName.text = player?.player_name ?? "D.N"
//        cell.playerNationalty.text = player?.player_country ?? "DN"
        cell.playerNumber.text = player?.player_number ?? "D.N"
        cell.playerPosition.text = player?.player_type ?? "D.N"
        cell.configure()
        
        return cell
    }
}

extension TeamViewController: UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderTeamCollectionReusableView.identifier, for: indexPath) as! HeaderTeamCollectionReusableView
        
        
        header.configure(with: UIImage(named: "noImage")!, name: "Loading")
        
        header.clubImage.loadImage(from: teamModel?.team_logo ?? "noImage")
        header.clubName.text = teamModel?.team_name
        
        header.onBackButtonTapped = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }

        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width , height: 335)
    }
    
}

extension TeamViewController: TeamViewProtocol{
    func showTeam(_ Team: [TeamModel]) {
        self.teamModel = Team.first
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
    }
    
    func showError(_ message: String) {
        print(message)
    }
    
    
}
