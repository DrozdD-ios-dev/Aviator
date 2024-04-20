//
//  FirstScreenAircraView.swift
//  Aviator
//
//  Created by Дрозд Денис on 20.04.2024.
//

import UIKit

final class FirstScreenAircraView: UIView {
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
        
        let circleView = UIView()
        circleView.layer.cornerRadius = 10
        circleView.backgroundColor = UIColor(named: "Gray43")
        circleView.layer.borderColor = UIColor.gray.cgColor
        circleView.layer.borderWidth = 2.5
        circleView.clipsToBounds = true
        
        addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        
        addSubview(labelName)
        labelName.snp.makeConstraints { make in
            make.leading.equalTo(circleView.snp.trailing).offset(10)
            make.centerY.equalToSuperview().offset(-15)
        }
    }
}
