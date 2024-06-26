//
//  ExtraSettingsMaintenanceViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 18.04.2024.
//

import UIKit

// MARK: - Protocol

protocol ExtraSettingsMaintenanceOutput: AnyObject {
    func updateTextfields(textFieldOne: String?, textFieldTwo: String?)
    func dismissViewController()
    func showAlert()
}

final class ExtraSettingsMaintenanceViewController: BaseController {
    
    // MARK: - Views
    
    private let mainExtraSettingsLable: UILabel = {
        let lable = UILabel()
        lable.text = "New aircraft"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 22)
        lable.textColor = .white
        return lable
    }()
    
    private let mainVerticalStack: UIStackView = {
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
    
    private lazy var modelTextField: CustomTextField = {
        let textField = CustomTextField(text: "   Model   ")
        textField.addTarget(self, action: #selector(modelTextFieldValueChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var serialNumberTextField: CustomTextField = {
        let textField = CustomTextField(text: "   Serial number   ")
        textField.addTarget(self, action: #selector(selialNumberTextFieldValueChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private let lastInspectionLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Last Inspection"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 15)
        lable.textColor = .white
        return lable
    }()
    
    private let upcomingInspectionLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Upcoming Inspection"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 15)
        lable.textColor = .white
        return lable
    }()
    
    private lazy var inspectionDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return datePicker
    }()
    
    private lazy var lastDataTextField: DateInspectionTextField = {
        let textField = DateInspectionTextField(text: "Select last date")
        textField.text = "Select last date"
        textField.inputView = inspectionDatePicker
        return textField
    }()
    
    private lazy var upcomingDataTextField: DateInspectionTextField = {
        let textField = DateInspectionTextField(text: "Select upcoming date")
        textField.inputView = inspectionDatePicker
        return textField
    }()
    
    private lazy var createExtraSettingsButton: BaseButton = {
        let button = BaseButton(text: "Create")
        button.addAction(UIAction {_ in self.createExtraSettingsButtonTapped()}, for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private let presenter: ExtraSettingsMaintenanceInput
    
    // MARK: - Init
    
    init(presenter: ExtraSettingsMaintenanceInput) {
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

private extension ExtraSettingsMaintenanceViewController {
    
    @objc func nameTextFieldValueChanged (_ textField: UITextField) {
        presenter.updateNameAircraft(text: textField.text ?? "")
    }
    
    @objc func modelTextFieldValueChanged (_ textField: UITextField) {
        presenter.updateModelAircraft(text: textField.text ?? "")
    }
    
    @objc func selialNumberTextFieldValueChanged (_ textField: UITextField) {
        presenter.updateSerialNumberAircraft(text: textField.text ?? "")
    }
    
    func createExtraSettingsButtonTapped() {
        presenter.processButtonActions()
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let text = formatter.string(from: sender.date)
        presenter.datePickerValueChanged(text: text)
    }
}

// MARK: - Output

extension ExtraSettingsMaintenanceViewController: ExtraSettingsMaintenanceOutput {
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Enter all value", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    func updateTextfields(textFieldOne: String?, textFieldTwo: String?) {
        if textFieldOne != nil {
            lastDataTextField.text = textFieldOne
        } else {
            upcomingDataTextField.text = textFieldTwo
        }
    }
}

// MARK: - Loyaut

private extension ExtraSettingsMaintenanceViewController {
    
    func addSubviews() {
        view.addSubview(mainExtraSettingsLable)
        view.addSubview(mainVerticalStack)
        mainVerticalStack.addArrangedSubview(nameTextField)
        mainVerticalStack.addArrangedSubview(modelTextField)
        mainVerticalStack.addArrangedSubview(serialNumberTextField)
        view.addSubview(lastInspectionLabel)
        view.addSubview(upcomingInspectionLabel)
        view.addSubview(lastDataTextField)
        view.addSubview(upcomingDataTextField)
        view.addSubview(createExtraSettingsButton)
    }
    
    func makeConstraints() {
        mainExtraSettingsLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(16)
        }
        
        mainVerticalStack.snp.makeConstraints { make in
            make.top.equalTo(mainExtraSettingsLable.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        modelTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        serialNumberTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        lastInspectionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-view.frame.width * 0.25)
            make.top.equalTo(mainVerticalStack.snp.bottom).offset(16)
        }
        
        upcomingInspectionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(view.frame.width * 0.23)
            make.top.equalTo(mainVerticalStack.snp.bottom).offset(16)
        }
        
        lastDataTextField.snp.makeConstraints { make in
            make.top.equalTo(lastInspectionLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview().offset(-view.frame.width * 0.25)
            make.width.equalTo(view.frame.width * 0.4)
            make.height.equalTo(50)
        }
        
        upcomingDataTextField.snp.makeConstraints { make in
            make.top.equalTo(upcomingInspectionLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview().offset(view.frame.width * 0.23)
            make.width.equalTo(view.frame.width * 0.4)
            make.height.equalTo(50)
        }
        
        createExtraSettingsButton.snp.makeConstraints { make in
            make.top.equalTo(upcomingDataTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}
