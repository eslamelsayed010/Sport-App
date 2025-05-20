//
//  LeagueDetailsCollectionView.swift
//  Sport App
//
//  Created by Macos on 15/05/2025.
//

import UIKit

private let reuseIdentifier = "Cell"

class LeagueDetailsCollectionView: UICollectionViewController , LeagueDetailsViewProtocol{
    func showUpcomingMatches(_ matches: [Match]) {
        self.upcomingMatches = matches
            DispatchQueue.main.async {
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
    }
    
    func showRecentMatches(_ matches: [Match]) {
        self.recentMatches = matches
        DispatchQueue.main.async {
            self.collectionView.reloadSections(IndexSet(integer: 2))
        }
    }


    
    func showError(_ message: String) {
        return
    }
    
    
    var selectedSport: Sport!
    var selectedLeagueId: Int!
    var presenter: LeagueDetailsPresenterProtocol!
    var upcomingMatches: [Match] = []
    var recentMatches: [Match] = []

    
    let sectionTitles = ["Upcoming Match", "Teams", "Events"]
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = UIColor(red: 24/255, green: 24/255, blue: 41/255, alpha: 1.0)

                self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
                collectionView.register(UINib(nibName: "UpcomingMatchCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingMatchCell")
                collectionView.register(UINib(nibName: "TeamCell", bundle: nil), forCellWithReuseIdentifier: "TeamCell")
                collectionView.register(UINib(nibName: "EventCell", bundle: nil), forCellWithReuseIdentifier: "EventCell")
                
                collectionView.register(SectionHeaderView.self,
                                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                        withReuseIdentifier: SectionHeaderView.reuseIdentifier)
                
                collectionView.collectionViewLayout = createLayout()
        
        presenter = LeagueDetailsPresenter(view: self, sport: selectedSport, leagueId: selectedLeagueId)
            presenter.fetchMatches()

    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section {
          case 0:
              return upcomingMatches.isEmpty ? 0 : 1
          case 1:
              return 5
          case 2:
            return recentMatches.count
          default:
              return 0
          }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingMatchCell", for: indexPath) as! UpcomingMatchCell
                if indexPath.item == 0, let match = upcomingMatches.first {
                    cell.configure(with: match)
                }
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCell
                cell.onImageTapped = {
                    let teamVC = TeamViewController(nibName: "TeamViewController", bundle: nil)
                    teamVC.modalTransitionStyle = .crossDissolve
                    teamVC.modalPresentationStyle = .fullScreen
                    self.present(teamVC, animated: true, completion: nil)
                }
                return cell

        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as! EventCell
            let match = recentMatches[indexPath.item]
            cell.team1.text = match.event_home_team ?? "-"
            cell.team2.text = match.event_away_team ?? "-"
            cell.matchScore.text = "\(match.event_final_result ?? " ")"

            if let logo1 = match.home_team_logo, !logo1.isEmpty {
                cell.team1Img.loadImage(from: logo1)
            } else {
                cell.team1Img.image = UIImage(named: "noImage")
            }

            if let logo2 = match.away_team_logo, !logo2.isEmpty {
                cell.team2Img.loadImage(from: logo2)
            } else {
                cell.team2Img.image = UIImage(named: "noImage")
            }

            return cell

            default:
                return UICollectionViewCell()
            }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier,
            for: indexPath
        ) as! SectionHeaderView

        let shouldShowHeader: Bool = {
            switch indexPath.section {
            case 0:
                return !upcomingMatches.isEmpty
            case 2:
                return !recentMatches.isEmpty
            default:
                return true
            }
        }()

        if shouldShowHeader {
            header.titleLabel.text = sectionTitles[indexPath.section]
            header.isHidden = false
        } else {
            header.titleLabel.text = nil
            header.isHidden = true
        }

        return header
    }


    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )

            switch sectionIndex {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [sectionHeader]
                return section

            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(150),
                                                      heightDimension: .absolute(170))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150),
                                                       heightDimension: .absolute(170))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 16, trailing: 12)
                section.boundarySupplementaryItems = [sectionHeader]
                
                return section

            default:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            }
        }
    }

}

class SectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderView"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
