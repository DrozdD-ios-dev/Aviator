//
//  CustomTextField.swift
//  Aviator
//
//  Created by Дрозд Денис on 18.04.2024.
//

import UIKit

final class CustomTextField: UITextField {
    convenience init(text: String) {
        self.init()
        let textField = self
        textField.textColor = .white
        textField.tintColor = .white
        textField.font = UIFont(name: EnumString.SFMed.rawValue, size: 15)
        textField.layer.cornerRadius = 18
        textField.layer.borderColor = UIColor(named: "Red239")?.cgColor
        textField.layer.borderWidth = 1.5
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        textField.attributedPlaceholder = NSAttributedString(string: " ", attributes: attributes)
        
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: EnumString.SFMed.rawValue, size: 15)
        label.textColor = UIColor(named: "Gray128")
        textField.leftView = label
        textField.leftViewMode = .always
    }
}
