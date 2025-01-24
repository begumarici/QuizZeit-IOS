//
//  AccountViewController.swift
//  QuizZeit
//
//  Created by Begüm Arıcı on 23.01.2025.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        checkIfUserAlreadyLoggedIn()
    }
    
    private func setupUI() {
        createAccountButton.layer.cornerRadius = 8
        signInButton.layer.cornerRadius = 8
    }

    // MARK: - Check Login Status
    private func checkIfUserAlreadyLoggedIn() {
        if Auth.auth().currentUser != nil {
            switchToProfile()
        }
    }

    // MARK: - Navigation
    @IBAction func createAccountTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignUp", sender: nil)
    }

    @IBAction func signInTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignIn", sender: nil)
    }

    private func switchToProfile() {
        // get the nav controller of the user tab
        if let navController = self.navigationController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            // add only the ProfileViewController to the navigation stack
            navController.setViewControllers([profileVC], animated: true)
        }
    }
}
