//
//  TeamViewController.swift
//  Sport App
//
//  Created by Macos on 16/05/2025.
//

import UIKit

class TeamViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupCollectionView()
        
    }
    
    func setupLayout() {
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10

        let screenWidth = UIScreen.main.bounds.width
        let totalHorizontalPadding: CGFloat = 16 + 16
        layout.itemSize = CGSize(width: screenWidth - totalHorizontalPadding, height: 100)
    }

    
    func setupCollectionView(){
        collectionView?.collectionViewLayout = layout
        collectionView?.register(TeamCollectionViewCell.nib(), forCellWithReuseIdentifier: TeamCollectionViewCell.identifier)
        
        collectionView?.register(UINib(nibName: "HeaderTeamCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderTeamCollectionReusableView.identifier)

        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.backgroundColor = UIColor(red: 26/255.0, green: 20/255.0, blue: 41/255.0, alpha: 1.0)
    }

}


extension TeamViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCollectionViewCell.identifier, for: indexPath) as! TeamCollectionViewCell
        
        cell.playerImage.layer.cornerRadius = cell.playerImage.frame.height / 2
        
        cell.configure()
        
        return cell
    }
}

extension TeamViewController: UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderTeamCollectionReusableView.identifier, for: indexPath) as! HeaderTeamCollectionReusableView
        
        
        header.configure(with: UIImage(named: "arsenal")!, name: "Arsenal")
        
        header.onBackButtonTapped = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }

        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width , height: 350)
    }
    
}
