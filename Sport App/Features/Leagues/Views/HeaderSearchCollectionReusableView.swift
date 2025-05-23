//
//  HeaderSearchCollectionReusableView.swift
//  Sport App
//
//  Created by Macos on 23/05/2025.
//

import UIKit

class HeaderSearchCollectionReusableView: UICollectionReusableView {
    static let identifier = "HeaderSearchCollectionReusableView"
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var onBackSearchTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = .clear
        searchBar.backgroundColor = .clear
        searchBar.tintColor = .white

        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .white
            textField.attributedPlaceholder = NSAttributedString(
                string: "Search...",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
            )
            
            if let iconView = textField.leftView as? UIImageView {
                iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
                iconView.tintColor = .white
            }
        }
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
