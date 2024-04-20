//
//  FirstScreenInspectionView.swift
//  Aviator
//
//  Created by Дрозд Денис on 20.04.2024.
//

import UIKit

final class FirstScreenInspectionView: UIView {
    
    // MARK: - Views
    
    private let madelView: FirstScreenAircraView = {
        let view = FirstScreenAircraView(name: "Model")
        return view
    }()
    
    private let serialNumberView: FirstScreenAircraView = {
        let view = FirstScreenAircraView(name: "Serial number")
        return view
    }()
    
    private let lastInspectionView: FirstScreenAircraView = {
        let view = FirstScreenAircraView(name: "Last inspection")
        return view
    }()
    
    private let upcomingInspectionView: FirstScreenAircraView = {
        let view = FirstScreenAircraView(name: "Upcoming inspection")
        return view
    }()
    
    private let verticalMainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        return stack
    }()
    
    private let horizontalOneStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 16
        return stack
    }()
    
    private let horizontalTwoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 16
        return stack
    }()
    
    // MARK: - Properties
    
    private var arrayTestLabels: [UILabel] = []
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLabels()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private func
    
    private func createLabels() {
        for _ in 0..<4 {
            let label = UILabel()
            label.textColor = .white
            label.font = UIFont(name: EnumString.SFMed.rawValue, size: 17)
            arrayTestLabels.append(label)
        }
    }
    
    // MARK: - Public Functions
    
    func configure(data: AircraftDataModel) {
        arrayTestLabels[0].text = data.model
        arrayTestLabels[1].text = data.serialNumber
        arrayTestLabels[2].text = data.lastInspection
        arrayTestLabels[3].text = data.upcomingInspection
    }
}

// MARK: - Layout

private extension FirstScreenInspectionView {
    func addSubviews() {
        addSubview(verticalMainStack)
        
        verticalMainStack.addArrangedSubview(horizontalOneStack)
        horizontalOneStack.addArrangedSubview(madelView)
        madelView.addSubview(arrayTestLabels[0])
        horizontalOneStack.addArrangedSubview(serialNumberView)
        serialNumberView.addSubview(arrayTestLabels[1])
        
        verticalMainStack.addArrangedSubview(horizontalTwoStack)
        horizontalTwoStack.addArrangedSubview(lastInspectionView)
        lastInspectionView.addSubview(arrayTestLabels[2])
        horizontalTwoStack.addArrangedSubview(upcomingInspectionView)
        upcomingInspectionView.addSubview(arrayTestLabels[3])
    }
    
    func makeConstraints() {
        verticalMainStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            print(verticalMainStack.frame.width)
        }
        
        madelView.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.width.equalTo(172)
            print((verticalMainStack.frame.width - 48) / 2)
        }
        
        serialNumberView.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.width.equalTo(172)
        }
        
        lastInspectionView.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.width.equalTo(172)
        }
        
        upcomingInspectionView.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.width.equalTo(172)
        }
        
        arrayTestLabels[0].snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.centerY.equalToSuperview().offset(10)
        }
        
        arrayTestLabels[1].snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.centerY.equalToSuperview().offset(10)
        }
        
        arrayTestLabels[2].snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.centerY.equalToSuperview().offset(10)
        }
        arrayTestLabels[3].snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.centerY.equalToSuperview().offset(10)
        }
    }
}
