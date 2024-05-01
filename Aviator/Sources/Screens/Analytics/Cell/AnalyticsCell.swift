//
//  AnalyticsCell.swift
//  Aviator
//
//  Created by Дрозд Денис on 25.04.2024.
//

import UIKit

final class AnalyticsCell: UICollectionViewCell {
    
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
    
    func configure(with model: VerificationCheckingSaveData) {
        nameLabel.text = model.name
        dateCheckingLabel.text = "Report from the \(model.date)"
    }
    
    // MARK: - Layout
    
    private func addSubviews() {
        contentView.addSubview(viewParameters)
        viewParameters.addSubview(nameLabel)
        viewParameters.addSubview(dateCheckingLabel)
    }
    
    private func makeConstraints() {
        viewParameters.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        dateCheckingLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
}
