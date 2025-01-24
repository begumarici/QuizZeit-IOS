//
//  CategoryViewController.swift
//  QuizZeit
//
//  Created by Begüm Arıcı on 19.01.2025.
//

import UIKit

class CategoryViewController: UIViewController {
    
    
    @IBOutlet weak var vocabularyButton: UIButton!
    @IBOutlet weak var grammarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleButtons([vocabularyButton, grammarButton])
    }
    
    
    @IBAction func vocabularyButtonTapped(_ sender: UIButton) {

        }
    
    
    @IBAction func grammarButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Info", message: "The Grammar option is not ready yet.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "vocabularySegue" {
               if let destinationVC = segue.destination as? LevelSelectionViewController {
                   print("Moving to LevelSelectionViewController with a Segue.")
               }
           }
       }
    
    func styleButtons(_ buttons: [UIButton]) {
        for button in buttons {
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            button.backgroundColor = UIColor(.white)
            button.setTitleColor(.black, for: .normal) 
        }
    }
    
}
    
