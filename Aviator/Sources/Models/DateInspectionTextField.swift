//
//  DateInspectionTextField.swift
//  Aviator
//
//  Created by Дрозд Денис on 19.04.2024.
//


import UIKit

final class DateInspectionTextField: UITextField {
    convenience init(text: String) {
        self.init()
        let textField = self
        textField.text = text
        textField.textColor = .white
        textField.tintColor = .white
        textField.font = UIFont(name: EnumString.SFMed.rawValue, size: 13)
        textField.layer.cornerRadius = 15
        textField.layer.borderColor = UIColor(named: "Red239")?.cgColor
        textField.layer.borderWidth = 1.5
        textField.textAlignment = .center
    }
}
