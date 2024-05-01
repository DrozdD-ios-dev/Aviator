//
//  ThirdScreenFlightViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import UIKit

// MARK: - Protocol

protocol ThirdScreenFlightOutput: AnyObject {
    func dismissViewController()
    func updateTextfield(textField: String)
    func showAlert() 
}

final class ThirdScreenFlightViewController: BaseController {
    
    // MARK: - Views
    
    private lazy var mainLabel: UILabel = {
        let lable = UILabel()
        lable.text = presenter.data.name
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 34)
        lable.textColor = .white
        return lable
    }()
    
    private let dateVerificationLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Date of verification"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 15)
        lable.textColor = .white
        return lable
    }()
    
    private lazy var checkingDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return datePicker
    }()
    
    private lazy var dateCheckingTextField: DateInspectionTextField = {
        let textField = DateInspectionTextField(text: "Select date")
        textField.inputView = checkingDatePicker
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private let systemsComponentsLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Systems and components"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 15)
        lable.textColor = .white
        return lable
    }()
    
    private lazy var okStatusSystemsButton: StatusSenderButton = {
        let button = StatusSenderButton(text: "Okey", color: UIColor(named: "Green101") ?? .systemGreen)
        button.addAction(UIAction {_ in self.okStatusSystemsButtonTapped()}, for: .touchUpInside)
        button.layer.borderColor = (UIColor(named: "Green101") ?? .systemGreen).cgColor.copy(alpha: 0.2)
        return button
    }()
    
    private lazy var violatedStatusSystemsButton: StatusSenderButton = {
        let button = StatusSenderButton(text: "Violated", color: .systemRed)
        button.addAction(UIAction {_ in self.violatedStatusSystemsButtonTapped()}, for: .touchUpInside)
        return button
    }()
    
    private let electronicsLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Electronics and avionics"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 15)
        lable.textColor = .white
        return lable
    }()
    
    private lazy var okStatusElectronicsButton: StatusSenderButton = {
        let button = StatusSenderButton(text: "Okey", color: UIColor(named: "Green101") ?? .systemGreen)
        button.addAction(UIAction {_ in self.okStatusElectronicsButtonTapped()}, for: .touchUpInside)
        button.layer.borderColor = (UIColor(named: "Green101") ?? .systemGreen).cgColor.copy(alpha: 0.2)
        return button
    }()
    
    private lazy var violatedStatusElectronicsButton: StatusSenderButton = {
        let button = StatusSenderButton(text: "Violated", color: .systemRed)
        button.addAction(UIAction {_ in self.violatedStatusElectronicsButtonTapped()}, for: .touchUpInside)
        return button
    }()
    
    private let identificationLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Identification and certification"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 15)
        lable.textColor = .white
        return lable
    }()
    
    private lazy var okStatusIdentificationButton: StatusSenderButton = {
        let button = StatusSenderButton(text: "Okey", color: UIColor(named: "Green101") ?? .systemGreen)
        button.addAction(UIAction {_ in self.okStatusIdentificationButtonTapped()}, for: .touchUpInside)
        button.layer.borderColor = (UIColor(named: "Green101") ?? .systemGreen).cgColor.copy(alpha: 0.2)
        return button
    }()
    
    private lazy var violatedStatusIdentificationButton: StatusSenderButton = {
        let button = StatusSenderButton(text: "Violated", color: .systemRed)
        button.addAction(UIAction {_ in self.violatedStatusIdentificationButtonTapped()}, for: .touchUpInside)
        return button
    }()
    
    private lazy var notesTextField: CustomTextField = {
        let textField = CustomTextField(text: "   Notes   ")
        textField.layer.borderColor = UIColor.white.cgColor
        textField.addTarget(self, action: #selector(notesTextFieldValueChanged(_:)), for: .editingChanged)
        return textField
    }()

    private lazy var makeReportButton: BaseButton = {
        let button = BaseButton(text: "Make a report")
        button.addAction(UIAction {_ in self.makeReportButtonTapped()}, for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private let presenter: ThirdScreenFlightInput
    
    // MARK: - Init
    
    init(presenter: ThirdScreenFlightInput) {
        self.presenter = presenter
        super.init()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray43")
        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
    }
    
    // MARK: - Private func
    
    private func activateSwitch(oneButton: UIButton, twoButton: UIButton) {
        oneButton.layer.borderColor = (UIColor(named: "Green101") ?? .systemGreen).cgColor.copy(alpha: 1)
        twoButton.layer.borderColor = UIColor.systemRed.cgColor.copy(alpha: 0.2)
        view.endEditing(true)
    }
    
    private func deactivateSwitch(oneButton: UIButton, twoButton: UIButton) {
        oneButton.layer.borderColor = (UIColor(named: "Green101") ?? .systemGreen).cgColor.copy(alpha: 0.2)
        twoButton.layer.borderColor = UIColor.systemRed.cgColor.copy(alpha: 1)
        view.endEditing(true)
    }
}


// MARK: - Actions

private extension ThirdScreenFlightViewController {

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let text = formatter.string(from: sender.date)
        presenter.datePickerValueChanged(text: text)
    }

    func okStatusSystemsButtonTapped() {
        activateSwitch(oneButton: okStatusSystemsButton, twoButton: violatedStatusSystemsButton)
        presenter.updateStatusSystemsButton(status: true)
    }
    
    func violatedStatusSystemsButtonTapped() {
        deactivateSwitch(oneButton: okStatusSystemsButton, twoButton: violatedStatusSystemsButton)
        presenter.updateStatusSystemsButton(status: false)
    }
    
    func okStatusElectronicsButtonTapped() {
        activateSwitch(oneButton: okStatusElectronicsButton, twoButton: violatedStatusElectronicsButton)
        presenter.updateStatusElectronicsButton(status: true)
    }
    
    func violatedStatusElectronicsButtonTapped() {
        deactivateSwitch(oneButton: okStatusElectronicsButton, twoButton: violatedStatusElectronicsButton)
        presenter.updateStatusElectronicsButton(status: false)
    }
    
    func okStatusIdentificationButtonTapped() {
        activateSwitch(oneButton: okStatusIdentificationButton, twoButton: violatedStatusIdentificationButton)
        presenter.updateStatusIdentificationButton(status: true)
    }
    
    func violatedStatusIdentificationButtonTapped() {
        deactivateSwitch(oneButton: okStatusIdentificationButton, twoButton: violatedStatusIdentificationButton)
        presenter.updateStatusIdentificationButton(status: false)
    }
    
    func makeReportButtonTapped() {
        presenter.makeReport()
    }
    
    @objc func notesTextFieldValueChanged (_ textField: UITextField) {
        presenter.updateNotes(text: textField.text ?? "")
    }
}

// MARK: - Output

extension ThirdScreenFlightViewController: ThirdScreenFlightOutput {
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }

    func updateTextfield(textField: String) {
        dateCheckingTextField.text = textField
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Enter all value", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

// MARK: - Loyaut

private extension ThirdScreenFlightViewController {
    
    func addSubviews() {
        view.addSubview(mainLabel)
        view.addSubview(dateVerificationLabel)
        view.addSubview(dateCheckingTextField)
        view.addSubview(systemsComponentsLabel)
        view.addSubview(okStatusSystemsButton)
        view.addSubview(violatedStatusSystemsButton)
        view.addSubview(electronicsLabel)
        view.addSubview(okStatusElectronicsButton)
        view.addSubview(violatedStatusElectronicsButton)
        view.addSubview(identificationLabel)
        view.addSubview(okStatusIdentificationButton)
        view.addSubview(violatedStatusIdentificationButton)
        view.addSubview(notesTextField)
        view.addSubview(makeReportButton)
    
    }
    
    func makeConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
        }
        
        dateVerificationLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(mainLabel.snp.bottom).offset(30)
        }
        
        dateCheckingTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(dateVerificationLabel.snp.bottom).offset(16)
            make.width.equalTo(view.frame.width * 0.4)
            make.height.equalTo(50)
        }
        
        systemsComponentsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(dateCheckingTextField.snp.bottom).offset(16)
        }

        okStatusSystemsButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(systemsComponentsLabel.snp.bottom).offset(16)
            make.height.equalTo(50)
            make.width.equalTo(view.frame.width / 3)
        }
        
        violatedStatusSystemsButton.snp.makeConstraints { make in
            make.leading.equalTo(okStatusSystemsButton.snp.trailing).offset(16)
            make.top.equalTo(systemsComponentsLabel.snp.bottom).offset(16)
            make.height.equalTo(50)
            make.width.equalTo(view.frame.width / 3)
        }
        
        electronicsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(okStatusSystemsButton.snp.bottom).offset(16)
        }
        
        okStatusElectronicsButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(electronicsLabel.snp.bottom).offset(16)
            make.height.equalTo(50)
            make.width.equalTo(view.frame.width / 3)
        }
        
        violatedStatusElectronicsButton.snp.makeConstraints { make in
            make.leading.equalTo(okStatusElectronicsButton.snp.trailing).offset(16)
            make.top.equalTo(electronicsLabel.snp.bottom).offset(16)
            make.height.equalTo(50)
            make.width.equalTo(view.frame.width / 3)
        }
        
        identificationLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(okStatusElectronicsButton.snp.bottom).offset(16)
        }
        
        okStatusIdentificationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(identificationLabel.snp.bottom).offset(16)
            make.height.equalTo(50)
            make.width.equalTo(view.frame.width / 3)
        }
        
        violatedStatusIdentificationButton.snp.makeConstraints { make in
            make.leading.equalTo(okStatusIdentificationButton.snp.trailing).offset(16)
            make.top.equalTo(identificationLabel.snp.bottom).offset(16)
            make.height.equalTo(50)
            make.width.equalTo(view.frame.width / 3)
        }
        
        notesTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(okStatusIdentificationButton.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
        makeReportButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(notesTextField.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
    }
}
