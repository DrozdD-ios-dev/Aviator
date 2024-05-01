//
//  FlightCell.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import UIKit

final class FlightCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    
    // MARK: - Views
    
    var viewParameters: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Gray62")
        view.layer.cornerRadius = 18
        return view
    }()
    
    private let startButton: UIView = {
        let button = UIView()
        button.backgroundColor = UIColor(named: "Red239")
        button.layer.cornerRadius = 24
        return button
    }()
    
    private let litleStartButton: UILabel = {
        let label = UILabel()
        label.text = "Start checking"
        label.font = UIFont(name: EnumString.SFMed.rawValue, size: 14)
        label.textColor = .white
        return label
    }()
    
    private let nameLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 20)
        lable.textColor = .white
        return lable
    }()
    
    private let dateCheckingLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 12)
        lable.textColor = .gray
        return lable
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public function
    
    func configure(with model: FlightCheckingSaveData) {
        nameLabel.text = model.name
        dateCheckingLabel.text = "Check before \(model.checkingDate)"
    }
    
    // MARK: - Layout
    
    private func addSubviews() {
        contentView.addSubview(viewParameters)
        viewParameters.addSubview(startButton)
        viewParameters.addSubview(nameLabel)
        viewParameters.addSubview(dateCheckingLabel)
        startButton.addSubview(litleStartButton)
    }
    
    private func makeConstraints() {
        viewParameters.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(16)
        }
        
        dateCheckingLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(16)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(50)
            make.width.equalTo(170)
        }
        
        litleStartButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
