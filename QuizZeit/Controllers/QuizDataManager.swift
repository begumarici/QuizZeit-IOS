//
//  QuizDataManager.swift
//  QuizZeit
//
//  Created by Begüm Arıcı on 8.01.2025.
//
import Foundation
import UIKit

struct Answer: Codable {
    let word: String
    let correctTranslation: String
}


class QuizDataManager {
    static let shared = QuizDataManager() // Singleton instance

    private init() {
        loadData()
    }

    var wrongAnswers: [Answer] = [] {
        didSet {
            saveData()
        }
    }
    
    var correctAnswers: [Answer] = [] {
        didSet {
            saveData()
        }
    }
    
    // correct and wrong answers are stored for future use
    
    // save data to UserDefaults
    private func saveData() {
        let encoder = JSONEncoder()
        if let wrongData = try? encoder.encode(wrongAnswers),
           let correctData = try? encoder.encode(correctAnswers) {
            UserDefaults.standard.set(wrongData, forKey: "wrongAnswers")
            UserDefaults.standard.set(correctData, forKey: "correctAnswers")
        }
    }
    
    // load data from UserDefaults
    private func loadData() {
        let decoder = JSONDecoder()
        if let wrongData = UserDefaults.standard.data(forKey: "wrongAnswers"),
           let correctData = UserDefaults.standard.data(forKey: "correctAnswers") {
            if let loadedWrongAnswers = try? decoder.decode([Answer].self, from: wrongData),
               let loadedCorrectAnswers = try? decoder.decode([Answer].self, from: correctData) {
                self.wrongAnswers = loadedWrongAnswers
                self.correctAnswers = loadedCorrectAnswers
            }
        }
    }
    
    func resetData() {
        wrongAnswers.removeAll()
        correctAnswers.removeAll()
        UserDefaults.standard.removeObject(forKey: "wrongAnswers")
        UserDefaults.standard.removeObject(forKey: "correctAnswers")
    }
}

