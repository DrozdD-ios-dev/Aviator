//
//  SettingsButton.swift
//  Aviator
//
//  Created by Дрозд Денис on 18.04.2024.
//

import UIKit

final class SettingsButton: UIButton {
    convenience init(text: String, image: UIImage) {
        self.init(type: .system)
        initEvent()
        backgroundColor = UIColor(named: "Gray62")
        layer.cornerRadius = 15
        layer.borderColor = UIColor(named: "Gray213")?.cgColor
        layer.borderWidth = 1.5
        
        let symbolImage = UIImageView()
        symbolImage.image = image
        
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: EnumString.SFMed.rawValue, size: 20)
        label.textColor = .white
        
        let labelDot = UILabel()
        labelDot.text = "..."
        labelDot.font = UIFont(name: EnumString.SFMed.rawValue, size: 30)
        labelDot.textColor = .white
        
        addSubview(symbolImage)
        symbolImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(symbolImage.snp.trailing).offset(20)
        }
        
        addSubview(labelDot)
        labelDot.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().inset(20)
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
