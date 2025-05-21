//
//  UpcomingMatchCell.swift
//  Sport App
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class UpcomingMatchCell: UICollectionViewCell {
    var onBackButtonTapped: (() -> Void)?
    var onFavoriteButtonTapped: (() -> Void)?
    
    @IBAction func favoriteBtn(_ sender: Any) {
        onFavoriteButtonTapped?()
    }
    
    @IBOutlet weak var favoriteButton: UIButton!

    @IBAction func arrowBack(_ sender: Any) {
        onBackButtonTapped?()
    }
    
    @IBOutlet weak var matchTime: UILabel!
    @IBOutlet weak var Team2Name: UILabel!
    
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team2Img: UIImageView!
    @IBOutlet weak var team1Img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor(red: 24/255, green: 24/255, blue: 41/255, alpha: 1.0)
                
                self.layer.cornerRadius = 10
                self.layer.masksToBounds = true
    }
    
    func configure(with match: Match) {
        team1Name.text = match.event_home_team
        Team2Name.text = match.event_away_team
        matchTime.text = match.event_date

        if let homeLogo = match.home_team_logo, let homeURL = URL(string: homeLogo), !homeLogo.isEmpty {
            DispatchQueue.global().async {
                if let homeData = try? Data(contentsOf: homeURL), let image = UIImage(data: homeData) {
                    DispatchQueue.main.async {
                        self.team1Img.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.team1Img.image = UIImage(named: "noImage")
                    }
                }
            }
        } else {
            self.team1Img.image = UIImage(named: "noImage")
        }

        if let awayLogo = match.away_team_logo, let awayURL = URL(string: awayLogo), !awayLogo.isEmpty {
            DispatchQueue.global().async {
                if let awayData = try? Data(contentsOf: awayURL), let image = UIImage(data: awayData) {
                    DispatchQueue.main.async {
                        self.team2Img.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.team2Img.image = UIImage(named: "noImage")
                    }
                }
            }
        } else {
            self.team2Img.image = UIImage(named: "noImage")
        }
    }

}

extension UpcomingMatchCell{
    func updateFavoriteIcon(isFavorite: Bool) {
        let imageName = isFavorite ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = isFavorite ? .yellow : .white
    }
}
