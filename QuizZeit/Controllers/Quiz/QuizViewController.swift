//
//  QuizViewController.swift
//  QuizZeit
//
//  Created by Begüm Arıcı on 10.12.2024.
//

import UIKit

struct Question {
    let question: String
    let answer: String
    let options: [String]
}

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var questions: [Question] = []
    var currentQuestionIndex = 0
    var score = 0
    var userAnswers: [(question: String, userAnswer: String, correctAnswer: String)] = []
    var selectedLevel: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadQuestions()
        displayQuestion()
        styleButtons()
        
            if let level = selectedLevel {
                self.title = "\(level)"
            }
        
        navigationItem.hidesBackButton = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    
    func styleButtons() {
        for button in answerButtons {
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            button.layer.backgroundColor = UIColor.white.cgColor
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = UIColor.white
        }
    }
    
    func loadQuestions() {
        guard let level = selectedLevel else { return }

        if let path = Bundle.main.path(forResource: level, ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                if let rawQuestions = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                    var allQuestions: [Question] = []
                    for (key, value) in rawQuestions {
                        var options = [value]
                        while options.count < 4 {
                            if let randomValue = rawQuestions.values.randomElement(), !options.contains(randomValue) {
                                options.append(randomValue)
                            }
                        }
                        options.shuffle()
                        allQuestions.append(Question(question: key, answer: value, options: options))
                    }
                    questions = allQuestions.shuffled() 
                    print("Questions Loaded: \(questions.count) questions")
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("Error: Could not find JSON file for level \(level).")
        }
    }




    func loadWordsFromJSON() -> [String] {
        var words: [String] = []
        
        if let path = Bundle.main.path(forResource: "B1", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                if let rawWords = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                    words = Array(rawWords.keys) 
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        return words
    }


    
    
    func displayQuestion() {
        guard currentQuestionIndex < questions.count else {
            performSegue(withIdentifier: "goToResults", sender: nil)
            return
        }
        
        let currentQuestion = questions[currentQuestionIndex]
        questionLabel.text = currentQuestion.question
        for (index, button) in answerButtons.enumerated() {
            if index < currentQuestion.options.count {
                button.setTitle(currentQuestion.options[index], for: .normal)
                button.isHidden = false
            } else {
                button.isHidden = true
            }
        }
        scoreLabel.text = "Score: \(score) / \(currentQuestionIndex)"
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.score = score
            destinationVC.solvedQuestions = currentQuestionIndex
            destinationVC.userAnswers = userAnswers
        }
    }

    @IBAction func answerTapped(_ sender: UIButton) {
        guard currentQuestionIndex < questions.count else { return }
        let currentQuestion = questions[currentQuestionIndex]
        
        let userAnswer = sender.title(for: .normal) ?? ""
        let correctAnswer = currentQuestion.answer
        
        userAnswers.append((question: currentQuestion.question, userAnswer: userAnswer, correctAnswer: correctAnswer))
        
        if sender.title(for: .normal) == currentQuestion.answer {
            sender.backgroundColor = UIColor(red: 143/255.0, green: 201/255.0, blue: 135/255.0, alpha: 1.0)
            score += 1
            
            // store the correctly answered word
            QuizDataManager.shared.correctAnswers.append(Answer(word: currentQuestion.question, correctTranslation: currentQuestion.answer))
            print("Added to correctAnswers: \(currentQuestion.question) - \(currentQuestion.answer)")
        } else {
            sender.backgroundColor = UIColor(red: 207/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1.0)
            
            // store the wrongly answered word
            QuizDataManager.shared.wrongAnswers.append(Answer(word: currentQuestion.question, correctTranslation: currentQuestion.answer))
            print("Added to wrongAnswers: \(currentQuestion.question) - \(currentQuestion.answer)")
            
            for button in answerButtons {
                if button.title(for: .normal) == currentQuestion.answer {
                    button.backgroundColor = UIColor(red: 143/255.0, green: 201/255.0, blue: 135/255.0, alpha: 1.0)
                }
            }
        }
        
        // block all the button interactions
        for button in answerButtons {
            button.isUserInteractionEnabled = false
        }
        
        // go to the next question after 1 sec
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.currentQuestionIndex += 1
            self.resetButtonState()
            self.displayQuestion()
        }
    }
    
    func resetButtonState() {
        for button in answerButtons {
            button.backgroundColor = UIColor.white
            button.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func endQuizTapped(_ sender: UIBarButtonItem) {
          let alert = UIAlertController(title: "Quit Quiz", message: "Are you sure you want to quit the quiz?", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
              self.performSegue(withIdentifier: "goToResults", sender: nil)
          }))
          alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
          present(alert, animated: true, completion: nil)
    }




}
