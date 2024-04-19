//
//  MaintenanceCell.swift
//  Aviator
//
//  Created by Дрозд Денис on 19.04.2024.
//

import UIKit

final class MaintenanceCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    
    // MARK: - Views
    
    var viewOneAircraft: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Gray62")
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let aircraftImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "airPlan")
        return image
    }()
    
    private let aircraftName: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 20)
        lable.textColor = .white
        return lable
    }()
    
    private let aircraftModel: UILabel = {
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
    
    func configure(with model: AircraftDataModel) {
        aircraftName.text = model.name
        aircraftModel.text = model.model
    }
    
    // MARK: - Layout
    
    private func addSubviews() {
        contentView.addSubview(viewOneAircraft)
        viewOneAircraft.addSubview(aircraftImage)
        viewOneAircraft.addSubview(aircraftName)
        viewOneAircraft.addSubview(aircraftModel)
    }
    
    private func makeConstraints() {
        viewOneAircraft.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
        
        aircraftImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
            
        }
        
        aircraftName.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-10)
            make.leading.equalTo(aircraftImage.snp.trailing).offset(16)
        }
        
        aircraftModel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(13)
            make.leading.equalTo(aircraftImage.snp.trailing).offset(16)
        }
    }
    
}
