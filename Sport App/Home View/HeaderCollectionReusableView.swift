//
//  HeaderCollectionReusableView.swift
//  Sport App
//
//  Created by Macos on 13/05/2025.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderCollectionReusableView"
    
    private var autoScrollTimer: Timer?
    private var currentIndex = 0
    
    private var carouselCollectionView: UICollectionView!
    private let images = ["1", "2", "3", "4"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCarousel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCarousel() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: bounds.height)
        layout.minimumLineSpacing = 0

        carouselCollectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        carouselCollectionView.isPagingEnabled = true
        carouselCollectionView.showsHorizontalScrollIndicator = false
        carouselCollectionView.backgroundColor = .clear

        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        carouselCollectionView.register(CarouselCell.self, forCellWithReuseIdentifier: "CarouselCell")

        addSubview(carouselCollectionView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        carouselCollectionView.frame = bounds
    }

    private func startAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            self?.scrollToNextItem()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }


    private func scrollToNextItem() {
        guard !images.isEmpty else { return }
        
        currentIndex = (currentIndex + 1) % images.count
        
        let indexPath = IndexPath(item: currentIndex, section: 0)
        carouselCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    
    public func configure() {
        carouselCollectionView.reloadData()
        startAutoScroll()
    }

}

class CarouselCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = UIColor.white.cgColor  
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:)")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

    public func configure(with imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}


extension HeaderCollectionReusableView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselCell
        cell.configure(with: images[indexPath.item])
        return cell
    }
}




