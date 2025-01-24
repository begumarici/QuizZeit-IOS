//
//  LevelSelectionViewController.swift
//  QuizZeit
//
//  Created by Begüm Arıcı on 8.01.2025.
//

import UIKit

class LevelSelectionViewController: UIViewController {
    
    @IBOutlet var levelButtons: [UIButton]!

    @IBOutlet var wrongAnswersButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleButtons(levelButtons)
        wrongButtonStyle()
    }
    
    @IBAction func levelSelected(_ sender: UIButton) {
        guard let level = sender.titleLabel?.text else { return }
        
        // Direct to quiz screen according to selected level
        performSegue(withIdentifier: "goToQuiz", sender: level)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToQuiz",
           let destinationVC = segue.destination as? QuizViewController,
           let selectedLevel = sender as? String {
            destinationVC.selectedLevel = selectedLevel
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
    
    func wrongButtonStyle() {
        wrongAnswersButton.layer.cornerRadius = 10
        wrongAnswersButton.layer.masksToBounds = true
        wrongAnswersButton.backgroundColor = UIColor(.white)
        wrongAnswersButton.setTitleColor(.black, for: .normal) 
        }
        
    
    }
    



