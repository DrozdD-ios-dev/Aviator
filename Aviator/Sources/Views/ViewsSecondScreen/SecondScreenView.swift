//
//  SecondScreenParametersViews.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import UIKit

final class SecondScreenView: UIView {
    convenience init(name: String, image: UIImage) {
        self.init()
        let view = self
        view.backgroundColor = UIColor(named: "Gray62")
        
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "Gray213")?.cgColor
        
        let labelName = UILabel()
        labelName.text = name
        labelName.textColor = .gray
        labelName.font = UIFont(name: EnumString.SFMed.rawValue, size: 11)
        
        let imageN = UIImageView()
        imageN.image = image
        
        addSubview(labelName)
        labelName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview().offset(10)
        }
        
        addSubview(imageN)
        imageN.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-25)
        }
    }
}

