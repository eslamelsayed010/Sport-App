//
//  OnboardingViewController.swift
//  Sport App
//
//  Created by Macos on 14/05/2025.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var exploreButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func exploreBtn(_ sender: Any) {
        let homeView = HomeViewController(nibName: "HomeViewController", bundle: nil)
        homeView.modalTransitionStyle = .crossDissolve
        homeView.modalPresentationStyle = .fullScreen
        self.present(homeView, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 24/255, green: 24/255, blue: 41/255, alpha: 1.0)
        
        exploreButton.layer.cornerRadius = 15
        exploreButton.clipsToBounds = true
        
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        label.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
    }
}
