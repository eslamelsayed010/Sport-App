//
//  EventCell.swift
//  Sport App
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class EventCell: UICollectionViewCell {

    @IBOutlet weak var team1Img: UIImageView!
    @IBOutlet weak var team2Img: UIImageView!
    @IBOutlet weak var matchScore: UILabel!
    @IBOutlet weak var team2: UILabel!
    @IBOutlet weak var team1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.backgroundColor = UIColor(red: 43/255, green: 43/255, blue: 61/255, alpha: 1.0)

                self.layer.cornerRadius = 20
                self.layer.masksToBounds = true
    }

}


extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
