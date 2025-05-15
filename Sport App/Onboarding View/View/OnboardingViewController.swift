//
//  OnboardingViewController.swift
//  Sport App
//
//  Created by Macos on 14/05/2025.
//

import UIKit

class OnboardingViewController: UIViewController {

    
    @IBAction func exploreBtn(_ sender: Any) {
        let homeView = HomeViewController(nibName: "HomeViewController", bundle: nil)
        homeView.modalTransitionStyle = .crossDissolve
        homeView.modalPresentationStyle = .fullScreen
        self.present(homeView, animated: true, completion: nil)
    }
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 24/255, green: 24/255, blue: 41/255, alpha: 1.0)
        
    
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
       

        label.font = UIFont.systemFont(ofSize: 40, weight: .semibold)

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
