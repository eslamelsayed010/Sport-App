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
        // Remove corner radius setting from here
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.masksToBounds = true
//        // Don't set cornerRadius here
//        imageView.backgroundColor = .clear
        imageView.image = image
        backgroundColor = bg
        sportLabel.text = text
//        sportLabel.textColor = .white
//        sportLabel.textAlignment = .center
//        sportLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        print("Setting label text to: \(text)")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        sportLabel.text = nil // Also reset the label
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "HomeCollectionViewCell", bundle: nil)
    }
}

