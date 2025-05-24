//
//  LeagueTableViewCell.swift
//  Sport App
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!

    // MARK: - Identifier
    static let idintefire = "LeagueTableViewCell"

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let horizontalInset: CGFloat = 16
        let verticalInset: CGFloat = 8

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(
            top: verticalInset,
            left: horizontalInset,
            bottom: verticalInset,
            right: horizontalInset
        ))

        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(red: 43/255, green: 43/255, blue: 61/255, alpha: 1.0)

        leagueImage.layer.cornerRadius = leagueImage.frame.height / 2
        leagueImage.clipsToBounds = true
    }

    // MARK: - Configuration
    func configure(with league: League) {
        leagueName.text = league.leagueName ?? "No Name"
        leagueName.textColor = .white

        leagueImage.image = UIImage(named: "noImage")

        if let logoString = league.leagueLogo,
           let url = URL(string: logoString) {
            let currentTag = tag + 1
            tag = currentTag

            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                           guard let self = self else { return }
                           DispatchQueue.main.async {
                               guard self.tag == currentTag else { return }
                               if let data = data, let image = UIImage(data: data) {
                                   self.leagueImage.image = image
                               } else {
                                   self.leagueImage.image = UIImage(named: "noImage")
                               }
                           }
                       }.resume()
        }
    }


    // MARK: - Helpers
    private func setupUI() {
        selectionStyle = .none
    }
}
