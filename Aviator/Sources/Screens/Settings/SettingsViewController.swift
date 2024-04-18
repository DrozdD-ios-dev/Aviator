//
//  SettingsViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import UIKit

// MARK: - Protocol

protocol SettingsOutput: AnyObject {
    
}

final class SettingsViewController: BaseController {
    
    // MARK: - Views
    
    private let navigationBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Red220")
        view.layer.cornerRadius = 50
        return view
    }()
    
    private let mainLable: UILabel = {
        let lable = UILabel()
        lable.text = "Settings"
        lable.font = UIFont(name: "SFProText-Medium", size: 34)
        lable.textColor = .white
        return lable
    }()
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        return stack
    }()
    
    private lazy var oneSettingsButton: SettingsButton = {
        let button = SettingsButton(text: "Share app", image: UIImage(named: "11") ?? UIImage._1)
        button.addAction(UIAction {_ in self.shareApp()}, for: .touchUpInside)
        return button
    }()
    
    private lazy var twoSettingsButton: SettingsButton = {
        let button = SettingsButton(text: "Usage Policy", image: UIImage(named: "22") ?? UIImage._1)
        button.addAction(UIAction {_ in self.usagePolicy()}, for: .touchUpInside)
        return button
    }()
    
    private lazy var threeSettingsButton: SettingsButton = {
        let button = SettingsButton(text: "Rate app", image: UIImage(named: "33") ?? UIImage._1)
        button.addAction(UIAction {_ in self.rateApp()}, for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private let presenter: SettingsInput
    
    // MARK: - Init
    
    init(presenter: SettingsInput) {
        self.presenter = presenter
        super.init()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray43")
        addSubviews()
        makeConstraints()
    }
}

// MARK: - Actions

extension SettingsViewController {
    
    func shareApp() {
        print("Share app")
    }
    
    func usagePolicy() {
        print("Usage Polisy")
    }
    
    func rateApp() {
        print("Rate app")
    }
}

// MARK: - Output

extension SettingsViewController: SettingsOutput {
    
}

// MARK: - Layout

private extension SettingsViewController {
    
    func addSubviews() {
        view.addSubview(navigationBarView)
        navigationBarView.addSubview(mainLable)
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(oneSettingsButton)
        mainStack.addArrangedSubview(twoSettingsButton)
        mainStack.addArrangedSubview(threeSettingsButton)
    }
    
    func makeConstraints() {
        navigationBarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(view.frame.height * 0.15)
            make.width.equalTo(view.frame.width * 2)
        }
        
        mainLable.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview().inset(16)
        }
        
        mainStack.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom).offset(50)
            make.horizontalEdges.equalToSuperview()
        }
        
        oneSettingsButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(62)
        }
        
        twoSettingsButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(62)
        }
        
        threeSettingsButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(62)
        }
    }
}
