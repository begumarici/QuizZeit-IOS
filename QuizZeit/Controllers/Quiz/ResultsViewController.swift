//
//  ResultsViewController.swift
//  QuizZeit
//
//  Created by Begüm Arıcı on 2.01.2025.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var goToStartButton: UIButton!
    @IBOutlet weak var resultTextView: UITextView!


    var score: Int = 0 // score that sent from QuizViewController
    var solvedQuestions: Int = 0
    var userAnswers: [(question: String, userAnswer: String, correctAnswer: String)] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "Score: \(score) correct out of \(solvedQuestions) questions"
        
        updateTextViewContent()
        
        styleButton()
        navigationItem.hidesBackButton = true
    }

    
    func updateTextViewContent() {
        resultTextView.backgroundColor = UIColor.white
        resultTextView.layer.cornerRadius = 10
        resultTextView.layer.masksToBounds = true
        resultTextView.layer.borderWidth = 1
        resultTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        let resultText = NSMutableAttributedString()
        
        if userAnswers.isEmpty {
            let noAnswersText = NSAttributedString(
                string: "No questions answered.",
                attributes: [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.darkGray]
            )
            resultText.append(noAnswersText)
        } else {
            let correctColor = UIColor(red: 143/255, green: 201/255, blue: 135/255, alpha: 1.0)
            let incorrectColor = UIColor(red: 207/255, green: 128/255, blue: 128/255, alpha: 1.0)
            
            for (index, answer) in userAnswers.enumerated() {
                let questionText = NSAttributedString(
                    string: "\(index + 1). Word: \(answer.question)\n",
                    attributes: [.font: UIFont.boldSystemFont(ofSize: 18)]
                )
                resultText.append(questionText)
                
                let userAnswerColor: UIColor = (answer.userAnswer == answer.correctAnswer) ? correctColor : incorrectColor
                let userAnswerText = NSAttributedString(
                    string: "Your answer: \(answer.userAnswer)\n",
                    attributes: [.foregroundColor: userAnswerColor, .font: UIFont.systemFont(ofSize: 18)]
                )
                resultText.append(userAnswerText)
                
                let correctAnswerText = NSAttributedString(
                    string: "Correct answer: \(answer.correctAnswer)\n\n",
                    attributes: [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 18)]
                )
                resultText.append(correctAnswerText)
            }
        }
        
        resultTextView.attributedText = resultText
        
        let maxHeight: CGFloat = view.frame.height * 0.47
        let sizeThatFits = resultTextView.sizeThatFits(CGSize(width: resultTextView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        resultTextView.heightAnchor.constraint(equalToConstant: min(sizeThatFits.height, maxHeight)).isActive = true
        
    }



    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    
    func styleButton() {
        goToStartButton.layer.cornerRadius = 10
        goToStartButton.layer.masksToBounds = true
        goToStartButton.setTitleColor(.black, for: .normal)
        goToStartButton.backgroundColor = UIColor.white
    }

    @IBAction func goToStart(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
