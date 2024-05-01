//
//  StatusSenderButton.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import UIKit

final class StatusSenderButton: UIButton {
    convenience init(text: String, color: UIColor) {
        self.init(type: .system)
        let button = self
        button.backgroundColor = UIColor(named: "Gray43")
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.layer.borderColor = color.cgColor
        button.isSelected = false
        
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: EnumString.SFMed.rawValue, size: 14)
        label.textColor = .white
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
