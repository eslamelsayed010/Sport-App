//
//  TeamCollectionViewCell.swift
//  Sport App
//
//  Created by Macos on 16/05/2025.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TeamCollectionViewCell"
    
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var playerNationalty: UILabel!
    @IBOutlet weak var playerPosition: UILabel!
    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerName: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playerName.numberOfLines = 0
        playerName.lineBreakMode = .byWordWrapping

        playerNumber.numberOfLines = 0
        playerNumber.lineBreakMode = .byWordWrapping

        playerPosition.numberOfLines = 0
        playerPosition.lineBreakMode = .byWordWrapping

        playerNationalty.numberOfLines = 0
        playerNationalty.lineBreakMode = .byWordWrapping
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = bounds

        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(red: 43/255, green: 43/255, blue: 61/255, alpha: 1.0)
    }

    
    public func configure() {
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TeamCollectionViewCell", bundle: nil)
    }

}
