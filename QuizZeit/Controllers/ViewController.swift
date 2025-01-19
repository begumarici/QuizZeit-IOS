//
//  ViewController.swift
//  QuizZeit
//
//  Created by Begüm Arıcı on 10.12.2024.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var practiceButton: UIButton!
    @IBOutlet weak var multiplayerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleButtons([practiceButton, multiplayerButton])
        
        
    }

    func styleButtons(_ buttons: [UIButton]) {
        for button in buttons {
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            button.backgroundColor = UIColor(.white)
            button.setTitleColor(.black, for: .normal)
            


        }
    }
    
    @IBAction func multiplayerButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Info", message: "The Multiplayer option is not ready yet.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

