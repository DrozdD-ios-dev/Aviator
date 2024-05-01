//
//  CreateCheckingViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import UIKit

// MARK: - Protocol

protocol CreateCheckingOutput: AnyObject {
    func dismissViewController()
    func showAlert()
}

final class CreateCheckingViewController: BaseController {
    
    // MARK: - Views
    
    private let mainCreateScreenLable: UILabel = {
        let lable = UILabel()
        lable.text = "New nearest flights"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 17)
        lable.textColor = .white
        return lable
    }()
    
    private lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField(text: "   Name   ")
        textField.addTarget(self, action: #selector(nameTextFieldValueChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private let checkingBeforeLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Checking before"
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
        return textField
    }()

    private lazy var saveParametersButton: BaseButton = {
        let button = BaseButton(text: "Add")
        button.addAction(UIAction {_ in self.saveParametersButtonTapped()}, for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private let presenter: CreateCheckingInput
    
    // MARK: - Init
    
    init(presenter: CreateCheckingInput) {
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

private extension CreateCheckingViewController {

    @objc func nameTextFieldValueChanged (_ textField: UITextField) {
        presenter.updateNameParameters(text: textField.text ?? "")
    }
    
    func saveParametersButtonTapped() {
        presenter.processButtonActions()
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let text = formatter.string(from: sender.date)
        dateCheckingTextField.text = text
        presenter.datePickerValueChanged(text: text)
    }
}

// MARK: - Output

extension CreateCheckingViewController: CreateCheckingOutput {
    
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

private extension CreateCheckingViewController {
    
    func addSubviews() {
        view.addSubview(mainCreateScreenLable)
        view.addSubview(nameTextField)
        view.addSubview(checkingBeforeLabel)
        view.addSubview(dateCheckingTextField)
        view.addSubview(saveParametersButton)
        
    }
    
    func makeConstraints() {
        mainCreateScreenLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(16)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(mainCreateScreenLable.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
      
        checkingBeforeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
        }
        
        dateCheckingTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(checkingBeforeLabel.snp.bottom).offset(16)
            make.width.equalTo(view.frame.width * 0.4)
            make.height.equalTo(50)
        }
        
        saveParametersButton.snp.makeConstraints { make in
            make.top.equalTo(dateCheckingTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}
