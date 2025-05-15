//
//  UpcomingMatchCell.swift
//  Sport App
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class UpcomingMatchCell: UICollectionViewCell {
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

}
