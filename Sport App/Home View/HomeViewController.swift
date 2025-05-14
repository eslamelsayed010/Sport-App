//
//  HomeViewController.swift
//  Sport App
//
//  Created by Macos on 13/05/2025.
//

import UIKit

class HomeViewController: UIViewController, UITabBarDelegate {
    @IBOutlet weak var tabBar: UITabBar!
    let sports = ["football", "basketball", "tennis", "baseball"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupCollectionView()
        tabBar.delegate = self
        //view.addSubview(collectionView!)
    }
    func tabBar(_ tabBarView: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item: \(item.title ?? "")")
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        collectionView?.frame = view.bounds
//    }
    
    func setupLayout() {
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 170, height: 170)
    }
    
    func setupCollectionView(){
        collectionView?.collectionViewLayout = layout
        //collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(HomeCollectionViewCell.nib(), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView?.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor(red: 26/255.0, green: 20/255.0, blue: 41/255.0, alpha: 1.0)
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("DONEE")
    }
}

extension HomeViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var customBackgroundColor = UIColor(red: 36/255.0, green: 30/255.0, blue: 50/255.0, alpha: 1.0)
        
        if indexPath.row == 0 || indexPath.row == 3{
            customBackgroundColor =  UIColor(red: 255/255.0, green: 114/255.0, blue: 80/255.0, alpha: 1.0)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        
        cell.configure(with: UIImage(named: sports[indexPath.row])!, text: sports[indexPath.row].capitalized, bg: customBackgroundColor)
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        
        header.configure()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width , height: 200)
    }
    
}
