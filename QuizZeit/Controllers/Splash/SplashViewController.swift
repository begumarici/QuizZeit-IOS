//
//  SplashViewController.swift
//  QuizZeit
//
//  Created by Begüm Arıcı on 25.01.2025.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delayTransition()
    }
    
    private func delayTransition() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.transitionToMainScreen()
        }
    }

    private func transitionToMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = tabBarController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        }
    }
}
