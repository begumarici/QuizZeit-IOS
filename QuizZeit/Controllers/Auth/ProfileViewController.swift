//
//  ProfileViewController.swift
//  QuizZeit
//
//  Created by Begüm Arıcı on 22.01.2025.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signOffButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayUserInfo()
    }
    
    private func setupUI() {
        signOffButton.layer.cornerRadius = 8
        signOffButton.setTitle("Sign off", for: .normal)
    }
    
    private func displayUserInfo() {
        if let user = Auth.auth().currentUser {
            let userId = user.uid
            let db = Firestore.firestore()
            
            // get user info from Firebase
            db.collection("users").document(userId).getDocument { (document, error) in
                if let error = error {
                    print("Error fetching user data: \(error.localizedDescription)")
                    self.nameLabel.text = user.displayName ?? user.email ?? "Unknown User"
                } else if let document = document, document.exists {
                    let data = document.data()
                    let username = data?["username"] as? String ?? user.displayName ?? "Unknown User"
                    self.nameLabel.text = username
                } else {
                    self.nameLabel.text = user.displayName ?? "Unknown User"
                }
            }
        } else {
            nameLabel.text = "Unknown User"
        }
    }

    
    // MARK: - IBActions
    @IBAction func signOffTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            switchToAccount()
        } catch {
            print("Failed to sign out: \(error.localizedDescription)")
            showAlert(title: "Error", message: "Failed to sign out. Please try again.")
        }
    }

    // MARK: - Navigation
    private func switchToAccount() {
        // switch to AccountViewController after user sign off
        if let navigationController = self.navigationController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let accountVC = storyboard.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
            navigationController.setViewControllers([accountVC], animated: true)
        } else {
            // if there is no nav bar go back to tab bar
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = tabBarController
                UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            }
        }
    }
    
    // MARK: - Helper Methods
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
