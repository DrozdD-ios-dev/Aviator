//
//  SecondScreenParametersView.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import UIKit

final class SecondScreenParametersViews: UIView {
    
    // MARK: - Views
    
    private let weightView: SecondScreenView = {
        let view = SecondScreenView(name: "Weight", image: UIImage(named: "dum30") ?? UIImage._1)
        return view
    }()
    
    private let balanceView: SecondScreenView = {
        let view = SecondScreenView(name: "Balance", image: UIImage(named: "air30") ?? UIImage._1)
        return view
    }()
    
    private let engineTempView: SecondScreenView = {
        let view = SecondScreenView(name: "Engine temperature", image: UIImage(named: "grad30") ?? UIImage._1)
        return view
    }()
    
    private let airPressureView: SecondScreenView = {
        let view = SecondScreenView(name: "Air pressure", image: UIImage(named: "wind30") ?? UIImage._1)
        return view
    }()
    
    private let fuelConsumptionView: SecondScreenView = {
        let view = SecondScreenView(name: "Fuel consumption", image: UIImage(named: "fuel30") ?? UIImage._1)
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
    
    private var parapetersLabels: [UILabel] = []
    
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
        for _ in 0..<5 {
            let label = UILabel()
            label.textColor = .white
            label.font = UIFont(name: EnumString.SFMed.rawValue, size: 18)
            parapetersLabels.append(label)
        }
    }
    
    private func createBalanceLabel(data: Bool) {
        if data {
            parapetersLabels[4].text = "Okay"
            parapetersLabels[4].textColor = UIColor(named: "Green101")
        } else {
            parapetersLabels[4].text = "Violated"
            parapetersLabels[4].textColor = .systemRed
        }
   }
    
    // MARK: - Public Functions
    
    func configure(data: MonitoringParametersSavedData) {
        parapetersLabels[0].text = data.weight
        parapetersLabels[1].text = data.engineTemp
        parapetersLabels[2].text = data.airPressure
        parapetersLabels[3].text = data.fuelConsumption
        createBalanceLabel(data: data.balanceStatus)
    }
}

// MARK: - Layout

private extension SecondScreenParametersViews {
    func addSubviews() {
        addSubview(verticalMainStack)
        verticalMainStack.addArrangedSubview(horizontalOneStack)
        horizontalOneStack.addArrangedSubview(weightView)
        weightView.addSubview(parapetersLabels[0])
        horizontalOneStack.addArrangedSubview(balanceView)
        balanceView.addSubview(parapetersLabels[4])
        verticalMainStack.addArrangedSubview(horizontalTwoStack)
        horizontalTwoStack.addArrangedSubview(engineTempView)
        engineTempView.addSubview(parapetersLabels[1])
        horizontalTwoStack.addArrangedSubview(airPressureView)
        airPressureView.addSubview(parapetersLabels[2])
        verticalMainStack.addArrangedSubview(fuelConsumptionView)
        fuelConsumptionView.addSubview(parapetersLabels[3])
        
    }
    
    func makeConstraints() {
        verticalMainStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        weightView.snp.makeConstraints { make in
            make.height.equalTo(122)
            make.width.equalTo(172)
        }
        
        balanceView.snp.makeConstraints { make in
            make.height.equalTo(122)
            make.width.equalTo(172)
        }
        
        engineTempView.snp.makeConstraints { make in
            make.height.equalTo(122)
            make.width.equalTo(172)
        }
        
        airPressureView.snp.makeConstraints { make in
            make.height.equalTo(122)
            make.width.equalTo(172)
        }
        
        fuelConsumptionView.snp.makeConstraints { make in
            make.height.equalTo(122)
            make.width.equalToSuperview()
        }
        
        parapetersLabels[0].snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        parapetersLabels[1].snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        parapetersLabels[2].snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        parapetersLabels[3].snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        parapetersLabels[4].snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-15)
        }
   
    }
}
