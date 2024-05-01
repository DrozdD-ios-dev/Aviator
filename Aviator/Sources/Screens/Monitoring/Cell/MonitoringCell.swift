//
//  MonitoringCell.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import UIKit

final class MonitoringCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    
    // MARK: - Views
    
    var viewParameters: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Gray62")
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    private let gearsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "gear20")
        image.tintColor = .white
        return image
    }()
    
    private let arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "arrow25")
        return image
    }()
    
    private let parameterName: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 17)
        lable.textColor = .white
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
    
    func configure(with model: MonitoringParametersSavedData) {
        parameterName.text = model.name
    }
    
    // MARK: - Layout
    
    private func addSubviews() {
        contentView.addSubview(viewParameters)
        viewParameters.addSubview(gearsImage)
        viewParameters.addSubview(parameterName)
        viewParameters.addSubview(arrowImage)
    }
    
    private func makeConstraints() {
        viewParameters.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
        
        gearsImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
            
        }
        
        parameterName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(gearsImage.snp.trailing).offset(16)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
}
