//
//  AnalyticsScreenParameters.swift
//  Aviator
//
//  Created by Дрозд Денис on 25.04.2024.
//

import UIKit

final class AnalyticsScreenParameters: UIView {
    
    // MARK: - Views
    
    private let verificationView: AnalyticsScreenView = {
        let view = AnalyticsScreenView(name: "Date of verification")
        return view
    }()
    
    private let systemView: AnalyticsScreenView = {
        let view = AnalyticsScreenView(name: "System and components")
        return view
    }()
    
    private let electronicView: AnalyticsScreenView = {
        let view = AnalyticsScreenView(name: "Electronics and avionics")
        return view
    }()
    
    private let identificationView: AnalyticsScreenView = {
        let view = AnalyticsScreenView(name: "Identification and\n certification")
        return view
    }()
    
    private let notesView: AnalyticsScreenView = {
        let view = AnalyticsScreenView(name: "Notes")
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
    
    private func createSystemLabel(data: Bool) {
        if data {
            parapetersLabels[1].text = "Okay"
            parapetersLabels[1].textColor = UIColor(named: "Green101")
        } else {
            parapetersLabels[1].text = "Violated"
            parapetersLabels[1].textColor = .systemRed
        }
   }
    
    private func createElectronicsLabel(data: Bool) {
        if data {
            parapetersLabels[2].text = "Okay"
            parapetersLabels[2].textColor = UIColor(named: "Green101")
        } else {
            parapetersLabels[2].text = "Violated"
            parapetersLabels[2].textColor = .systemRed
        }
   }
    
    private func createIdentificationLabel(data: Bool) {
        if data {
            parapetersLabels[3].text = "Okay"
            parapetersLabels[3].textColor = UIColor(named: "Green101")
        } else {
            parapetersLabels[3].text = "Violated"
            parapetersLabels[3].textColor = .systemRed
        }
   }
    
    // MARK: - Public Functions
    
    func configure(data: VerificationCheckingSaveData) {
        parapetersLabels[0].text = data.date
        parapetersLabels[4].text = data.notes
        createSystemLabel(data: data.systemComponents)
        createElectronicsLabel(data: data.electronics)
        createIdentificationLabel(data: data.identification)
    }
}

// MARK: - Layout

private extension AnalyticsScreenParameters {
    func addSubviews() {
        addSubview(verticalMainStack)
        verticalMainStack.addArrangedSubview(horizontalOneStack)
        horizontalOneStack.addArrangedSubview(verificationView)
        verificationView.addSubview(parapetersLabels[0])
        horizontalOneStack.addArrangedSubview(systemView)
        systemView.addSubview(parapetersLabels[1])
        verticalMainStack.addArrangedSubview(horizontalTwoStack)
        horizontalTwoStack.addArrangedSubview(electronicView)
        electronicView.addSubview(parapetersLabels[2])
        horizontalTwoStack.addArrangedSubview(identificationView)
        identificationView.addSubview(parapetersLabels[3])
        verticalMainStack.addArrangedSubview(notesView)
        notesView.addSubview(parapetersLabels[4])
        
    }
    
    func makeConstraints() {
        verticalMainStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        verificationView.snp.makeConstraints { make in
            make.height.equalTo(122)
            make.width.equalTo(172)
        }
        
        systemView.snp.makeConstraints { make in
            make.height.equalTo(122)
            make.width.equalTo(172)
        }
        
        electronicView.snp.makeConstraints { make in
            make.height.equalTo(122)
            make.width.equalTo(172)
        }
        
        identificationView.snp.makeConstraints { make in
            make.height.equalTo(122)
            make.width.equalTo(172)
        }
        
        notesView.snp.makeConstraints { make in
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
