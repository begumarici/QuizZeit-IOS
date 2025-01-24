//
//  AuthModel.swift
//  QuizZeit
//
//  Created by Begüm Arıcı on 23.01.2025.
//

import Foundation
import GoogleSignIn
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore

enum ValidationError: LocalizedError {
    case fieldsAreEmpty
    case clientIDMissing
    case missingGoogleCredentials

    var errorDescription: String? {
        switch self {
        case .fieldsAreEmpty:
            return "All fields must be filled in. Please check your input."
        case .clientIDMissing:
            return "Google Sign-In Client ID is missing. Please check your Firebase configuration."
        case .missingGoogleCredentials:
            return "Google Sign-In credentials are missing. Please try again."
        }
    }
}

@MainActor
class AuthView: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Email & Password Sign Up
    func signUp(username: String, email: String, password: String) async throws {
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty else {
            throw ValidationError.fieldsAreEmpty
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            
            // Save user info in Firestore
            let db = Firestore.firestore()
            try await db.collection("users").document(authResult.user.uid).setData([
                "username": username,
                "email": email,
                "createdAt": FieldValue.serverTimestamp(),
                "loginMethod": "e-mail",
            ])
        } catch let error as NSError {
            print("Sign Up Failed: \(error.localizedDescription)")
            throw error
        }
    }
    
    // MARK: - Email & Password Sign In
    func signIn(email: String, password: String) async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw ValidationError.fieldsAreEmpty
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch let error as NSError {
            print("Sign In Failed: \(error.localizedDescription)")
            throw error
        }
    }
    
    // MARK: - Google Sign-In
    func googleSignIn(presenting viewController: UIViewController) async throws {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw ValidationError.clientIDMissing
        }

        let config = GIDConfiguration(clientID: clientID)
        isLoading = true
        defer { isLoading = false }
        
        do {
            let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: viewController)
            
            // google id info
            let idToken = signInResult.user.idToken?.tokenString ?? ""
            let accessToken = signInResult.user.accessToken.tokenString
            
            // check if it's empty
            guard !idToken.isEmpty, !accessToken.isEmpty else {
                throw ValidationError.missingGoogleCredentials
            }
            
            // create firebase id info
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            // sign in with Firebase
            let authResult = try await Auth.auth().signIn(with: credential)
            
            // save or update user info to Firebase
            let db = Firestore.firestore()
            let userID = authResult.user.uid
            let userDocument = db.collection("users").document(userID)
            let documentSnapshot = try await userDocument.getDocument()
            
            let userData: [String: Any] = [
                "username": signInResult.user.profile?.name ?? "No Name",
                "email": signInResult.user.profile?.email ?? "No Email",
                "loginMethod": "google",
                "createdAt": documentSnapshot.exists ? documentSnapshot.data()?["createdAt"] ?? FieldValue.serverTimestamp() : FieldValue.serverTimestamp()
            ]
            
            if documentSnapshot.exists {
                try await userDocument.updateData(userData)
            } else {
                try await userDocument.setData(userData)
            }
        } catch let error as NSError {
            print("Google Sign-In Failed: \(error.localizedDescription)")
            throw error
        }
    }
}
