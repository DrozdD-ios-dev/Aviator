//
//  BaseButton.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import UIKit

final class BaseButton: UIButton {
    convenience init(text: String) {
        self.init(type: .system)
        backgroundColor = UIColor(named: "Red239")
        layer.cornerRadius = 24
  
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
