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
        initEvent()
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
    
    private func initEvent() {
        addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
        addTarget(self, action: #selector(buttonReleased), for: .touchUpOutside)
    }
    
    @objc private func buttonPressed() {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 0.7
        }
    }
    
    @objc private func buttonReleased() {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 1.0
        }
    }
}
