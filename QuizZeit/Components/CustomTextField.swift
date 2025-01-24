//
//  CustomTextField.swift
//  QuizZeit
//
//  Created by Begüm Arıcı on 23.01.2025.
//

import UIKit

class CustomTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }

    private func setupAppearance() {
        if let placeholderText = self.placeholder {
            self.attributedPlaceholder = NSAttributedString(
                string: placeholderText,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
            )
        }
        
        self.backgroundColor = UIColor(white: 1, alpha: 0.2)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 8
        self.textColor = .white
    }
}
