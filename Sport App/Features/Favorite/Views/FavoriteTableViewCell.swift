//
//  FavoriteTableViewCell.swift
//  Sport App
//
//  Created by Macos on 18/05/2025.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var leagueImage: UIImageView!
    
    @IBOutlet weak var leagueName: UILabel!
    static let idintefire = "FavoriteTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let horizontalInset: CGFloat = 16
        let verticalInset: CGFloat = 8

        let insetFrame = contentView.frame.inset(by: UIEdgeInsets(
            top: verticalInset,
            left: horizontalInset,
            bottom: verticalInset,
            right: horizontalInset
        ))

        contentView.frame = insetFrame
        
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(red: 43/255, green: 43/255, blue: 61/255, alpha: 1.0)
    }




    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
