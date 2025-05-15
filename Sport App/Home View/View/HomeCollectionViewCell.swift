//
//  HomeCollectionViewCell.swift
//  Sport App
//
//  Created by Macos on 13/05/2025.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var sportLabel: UILabel!
    

    
    static let identifier = "HomeCollectionViewCell"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.borderWidth = 2.0
        contentView.layer.cornerRadius = 15.0
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = 15.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
    }

    public func configure(with image: UIImage, text: String, bg: UIColor?) {
        imageView.image = image
        backgroundColor = bg
        sportLabel.text = text
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        sportLabel.text = nil
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "HomeCollectionViewCell", bundle: nil)
    }
}

