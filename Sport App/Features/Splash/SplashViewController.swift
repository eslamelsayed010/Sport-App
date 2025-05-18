//
//  SplashViewController.swift
//  Sport App
//
//  Created by Macos on 14/05/2025.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    private var animationView: LottieAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 24/255, green: 24/255, blue: 41/255, alpha: 1.0)
        playLottieAnimation()
    }

    func playLottieAnimation() {
        animationView = LottieAnimationView(name: "splash")
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1.0

        animationView.backgroundColor = .clear
        animationView.layer.backgroundColor = UIColor.clear.cgColor

        view.addSubview(animationView)

        animationView.play { finished in
            if finished {
                self.goToMainApp()
            }
        }
    }


    func goToMainApp() {
        let mainVC = OnboardingViewController(nibName: "OnboardingViewController", bundle: nil)
        mainVC.modalTransitionStyle = .crossDissolve
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC, animated: true, completion: nil)
    }
}
