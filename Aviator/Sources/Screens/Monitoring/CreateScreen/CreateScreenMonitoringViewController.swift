//
//  CreateScreenMonitoringViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import UIKit

// MARK: - Protocol

protocol CreateScreenMonitoringOutput: AnyObject {
    func dismissViewController()
    func showAlert()
}

final class CreateScreenMonitoringViewController: BaseController {
    
    // MARK: - Views
    
    private let mainCreateScreenLable: UILabel = {
        let lable = UILabel()
        lable.text = "New monitoring of parameters"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 17)
        lable.textColor = .white
        return lable
    }()
    
    private let firstVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        return stack
    }()
    
    private let secondVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        return stack
    }()
    
    private lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField(text: "   Name   ")
        textField.addTarget(self, action: #selector(nameTextFieldValueChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var weightTextField: CustomTextField = {
        let textField = CustomTextField(text: "   Weight   ")
        textField.addTarget(self, action: #selector(weightTextFieldValueChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private let balanceLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Balance"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 15)
        lable.textColor = .white
        return lable
    }()
    
    private lazy var okeyStatusButton: StatusSenderButton = {
        let button = StatusSenderButton(text: "Okey", color: UIColor(named: "Green101") ?? .systemGreen)
        button.addAction(UIAction {_ in self.okeyStatusButtonTapped()}, for: .touchUpInside)
        button.layer.borderColor = (UIColor(named: "Green101") ?? .systemGreen).cgColor.copy(alpha: 0.2)
        return button
    }()
    
    private lazy var violatedStatusButton: StatusSenderButton = {
        let button = StatusSenderButton(text: "Violated", color: .systemRed)
        button.addAction(UIAction {_ in self.violatedStatusButtonTapped()}, for: .touchUpInside)
        return button
    }()
    
    private lazy var engineTemperatureTextField: CustomTextField = {
        let textField = CustomTextField(text: "   Engine temperature   ")
        textField.addTarget(self, action:  #selector(engineTemperatureTextFieldValueChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var airPressureTextField: CustomTextField = {
        let textField = CustomTextField(text: "   Air pressure   ")
        textField.addTarget(self, action: #selector(airPressureTextFieldValueChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var fuelConsumptionTextField: CustomTextField = {
        let textField = CustomTextField(text: "   Fuel consumption   ")
        textField.addTarget(self, action: #selector(fuelConsumptionTextFieldValueChanged(_:)), for: .editingChanged)
        return textField
    }()

    private lazy var saveParametersButton: BaseButton = {
        let button = BaseButton(text: "Create")
        button.addAction(UIAction {_ in self.saveParametersButtonTapped()}, for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private let presenter: CreateScreenMonitoringInput
    
    // MARK: - Init
    
    init(presenter: CreateScreenMonitoringInput) {
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

private extension CreateScreenMonitoringViewController {

    @objc func nameTextFieldValueChanged (_ textField: UITextField) {
        presenter.updateNameParameters(text: textField.text ?? "")
    }
    
    @objc func weightTextFieldValueChanged (_ textField: UITextField) {
        presenter.updateWeightParameters(text: textField.text ?? "")
    }
    
    func okeyStatusButtonTapped() {
        okeyStatusButton.layer.borderColor = (UIColor(named: "Green101") ?? .systemGreen).cgColor.copy(alpha: 1)
        violatedStatusButton.layer.borderColor = UIColor.systemRed.cgColor.copy(alpha: 0.2)
        presenter.updateStatusButton(status: true)
        view.endEditing(true)
    }
    
    func violatedStatusButtonTapped() {
        okeyStatusButton.layer.borderColor = (UIColor(named: "Green101") ?? .systemGreen).cgColor.copy(alpha: 0.2)
        violatedStatusButton.layer.borderColor = UIColor.systemRed.cgColor.copy(alpha: 1)
        presenter.updateStatusButton(status: false)
        view.endEditing(true)
    }
    
    @objc func engineTemperatureTextFieldValueChanged (_ textField: UITextField) {
        presenter.updateEngineTempParameters(text: textField.text ?? "")
    }
    
    @objc func airPressureTextFieldValueChanged (_ textField: UITextField) {
        presenter.updateAirPressureParameters(text: textField.text ?? "")
    }
    
    @objc func fuelConsumptionTextFieldValueChanged (_ textField: UITextField) {
        presenter.updateFuelConsumptionParameters(text: textField.text ?? "")
    }
    
    func saveParametersButtonTapped() {
        presenter.processButtonActions()
    }
}

// MARK: - Output

extension CreateScreenMonitoringViewController: CreateScreenMonitoringOutput {
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Enter all value", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

// MARK: - Loyaut

private extension CreateScreenMonitoringViewController {
    
    func addSubviews() {
        view.addSubview(mainCreateScreenLable)
        view.addSubview(firstVerticalStack)
        firstVerticalStack.addArrangedSubview(nameTextField)
        firstVerticalStack.addArrangedSubview(weightTextField)
        view.addSubview(balanceLabel)
        view.addSubview(okeyStatusButton)
        view.addSubview(violatedStatusButton)
        view.addSubview(secondVerticalStack)
        secondVerticalStack.addArrangedSubview(engineTemperatureTextField)
        secondVerticalStack.addArrangedSubview(airPressureTextField)
        secondVerticalStack.addArrangedSubview(fuelConsumptionTextField)
        view.addSubview(saveParametersButton)
        
    }
    
    func makeConstraints() {
        mainCreateScreenLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(16)
        }
        
        firstVerticalStack.snp.makeConstraints { make in
            make.top.equalTo(mainCreateScreenLable.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(firstVerticalStack.snp.bottom).offset(16)
        }
        
        okeyStatusButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(balanceLabel.snp.bottom).offset(16)
            make.height.equalTo(50)
            make.width.equalTo(view.frame.width / 3)
        }
        
        violatedStatusButton.snp.makeConstraints { make in
            make.leading.equalTo(okeyStatusButton.snp.trailing).offset(16)
            make.top.equalTo(balanceLabel.snp.bottom).offset(16)
            make.height.equalTo(50)
            make.width.equalTo(view.frame.width / 3)
        }
        
        secondVerticalStack.snp.makeConstraints { make in
            make.top.equalTo(okeyStatusButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
        }
        
        engineTemperatureTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        airPressureTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        fuelConsumptionTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        saveParametersButton.snp.makeConstraints { make in
            make.top.equalTo(fuelConsumptionTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}
