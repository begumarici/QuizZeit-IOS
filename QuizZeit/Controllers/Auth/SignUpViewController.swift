//
//  SignUpViewController.swift
//  QuizZeit
//
//  Created by Begüm Arıcı on 23.01.2025.
//


import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    private let viewModel = AuthView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        passwordTextField.isSecureTextEntry = true
        googleSignInButton.layer.cornerRadius = 8
        signUpButton.layer.cornerRadius = 8
    }

    // MARK: - IBActions
    @IBAction func signUpTapped(_ sender: UIButton) {
        Task {
            guard validateInputFields() else { return }
            do {
                // save user to Firebase Auth
                let userCredential = try await Auth.auth().createUser(
                    withEmail: emailTextField.text ?? "",
                    password: passwordTextField.text ?? ""
                )
                
                let username = usernameTextField.text ?? ""
                let userId = userCredential.user.uid
                let db = Firestore.firestore()
                try await db.collection("users").document(userId).setData([
                    "username": username,
                    "email": emailTextField.text ?? "",
                    "loginMethod": "email",
                    "createdAt": FieldValue.serverTimestamp()
                ])
                
                switchToProfile()
            } catch {
                handleError(error)
            }
        }
    }



    @IBAction func googleSignInTapped(_ sender: UIButton) {
        Task {
            do {
                try await viewModel.googleSignIn(presenting: self)

                if let user = Auth.auth().currentUser {
                    let userId = user.uid
                    let displayName = user.displayName ?? "Unknown User"
                    let email = user.email ?? ""

                    let db = Firestore.firestore()
                    try await db.collection("users").document(userId).setData([
                        "username": displayName,
                        "email": email,
                        "loginMethod": "google",
                        "createdAt": FieldValue.serverTimestamp()
                    ], merge: true)
                }
                
                switchToProfile()
            } catch {
                handleError(error)
            }
        }
    }



    // MARK: - Navigation
    private func switchToProfile() {
        // switch to ProfileViewController
        if let navigationController = self.navigationController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            navigationController.setViewControllers([profileVC], animated: true)
        } else {
            // if there is no nav controller go back to tab bar
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = tabBarController
                UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromRight, animations: nil)
            }
        }
    }

    // MARK: - Helper Methods
    private func validateInputFields() -> Bool {
        guard let username = usernameTextField.text, !username.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Validation Error", message: "Please fill in all fields.")
            return false
        }
        return true
    }

    private func handleError(_ error: Error) {
        if let validationError = error as? ValidationError {
            showAlert(title: "Error", message: validationError.errorDescription ?? "An unknown error occurred.")
        } else {
            showAlert(title: "Error", message: error.localizedDescription)
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
