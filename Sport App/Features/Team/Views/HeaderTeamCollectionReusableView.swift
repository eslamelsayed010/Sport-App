//
//  HeaderTeamCollectionReusableView.swift
//  Sport App
//
//  Created by Macos on 16/05/2025.
//

import UIKit

class HeaderTeamCollectionReusableView: UICollectionReusableView {
    var onBackButtonTapped: (() -> Void)?
    
    @IBAction func arrowBack(_ sender: Any) {
        onBackButtonTapped?()
    }
    
    static let identifier = "HeaderTeamCollectionReusableView"
    
    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var clubImage: UIImageView!
    
    public func configure(with image: UIImage, name: String){
        clubImage.image = image
        clubName.text = name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //clubImage.layer.cornerRadius = clubImage.frame.size.width / 2
        clubImage.clipsToBounds = true
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        clubName.textColor = UIColor(red: 255/255.0, green: 114/255.0, blue: 80/255.0, alpha: 1.0)
//        
//        clubImage.layer.cornerRadius = clubImage.frame.size.width / 2
//        clubImage.clipsToBounds = true
//        
//        clubImage.backgroundColor = UIColor(red: 30/255.0, green: 30/255.0, blue: 30/255.0, alpha: 1.0)
        
    }

    
}
