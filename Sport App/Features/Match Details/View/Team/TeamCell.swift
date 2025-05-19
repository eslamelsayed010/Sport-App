//
//  TeamCell.swift
//  Sport App
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class TeamCell: UICollectionViewCell {
    var onImageTapped: (() -> Void)?
    @IBOutlet weak var TeamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor(red: 24/255, green: 24/255, blue: 41/255, alpha: 1.0)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true

        teamLogo.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        teamLogo.addGestureRecognizer(tapGesture)
    }

    @objc func imageTapped() {
        onImageTapped?()
    }
}

