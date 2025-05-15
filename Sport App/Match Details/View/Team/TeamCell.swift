//
//  TeamCell.swift
//  Sport App
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class TeamCell: UICollectionViewCell {

    @IBOutlet weak var TeamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor(red: 24/255, green: 24/255, blue: 41/255, alpha: 1.0)
                
                self.layer.cornerRadius = 10
                self.layer.masksToBounds = true
    }

}
