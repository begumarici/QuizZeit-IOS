//
//  TabBarController.swift
//  QuizZeit
//
//  Created by Begüm Arıcı on 23.01.2025.
//

import UIKit
import FirebaseAuth

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    // MARK: - Check when tab is changed
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // if the user wants to switch to the tab
        if let navController = viewController as? UINavigationController,
           navController.viewControllers.first is AccountViewController {
            // check if the user is signed in
            if Auth.auth().currentUser != nil {
                // if the user is signed in, navigate to ProfileViewControlle
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                navController.setViewControllers([profileVC], animated: false)
            } else {
                // if the user is not signed in, show AccountViewController
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let accountVC = storyboard.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
                navController.setViewControllers([accountVC], animated: false)
            }
        }
        return true
    }
}
