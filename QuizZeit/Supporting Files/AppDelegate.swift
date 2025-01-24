//
//  AppDelegate.swift
//  QuizZeit
//
//  Created by Begüm Arıcı on 10.12.2024.
//

import UIKit
import FirebaseCore
import GoogleSignIn
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("Google Sign-In Client ID not found. Please check your Firebase configuration.")
        }
        
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        
        determineInitialViewController()

        return true
    }

    // MARK: - User Session Check
    private func determineInitialViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // check if the user is signed in
        if Auth.auth().currentUser != nil {
            // if there is a signed-in user, navigate to profile screen
            let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
            window?.rootViewController = profileVC
        } else {
            // if the user is not signed in, show to sign in screen
            let loginVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
            window?.rootViewController = loginVC
        }
        
        window?.makeKeyAndVisible()
    }

    // MARK: - Google Sign-In URL Handler
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }

    // MARK: - UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}
