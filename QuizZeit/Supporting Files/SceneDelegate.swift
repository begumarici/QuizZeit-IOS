//
//  SceneDelegate.swift
//  QuizZeit
//
//  Created by Begüm Arıcı on 10.12.2024.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController

        if Auth.auth().currentUser != nil {
            if let navigationController = tabBarController.viewControllers?[3] as? UINavigationController {
                let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                navigationController.setViewControllers([profileVC], animated: false)
            }
        }

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
