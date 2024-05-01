//
//  AnalyticsScreenView.swift
//  Aviator
//
//  Created by Дрозд Денис on 25.04.2024.
//

import UIKit

final class AnalyticsScreenView: UIView {
    convenience init(name: String) {
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
        labelName.numberOfLines = 2
       
        let circleView = UIView()
        circleView.layer.cornerRadius = 10
        circleView.backgroundColor = UIColor(named: "Gray62")
        circleView.layer.borderColor = UIColor.gray.cgColor
        circleView.layer.borderWidth = 2.5
        circleView.clipsToBounds = true
        
        addSubview(labelName)
        labelName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview().offset(5)
        }
        
        addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(20)
            make.top.equalToSuperview().offset(25)
        }
        
      
    }
}

