//
//  SecondScreenMonitoringViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import UIKit

// MARK: - Protocol

protocol SecondScreenMonitoringOutput: AnyObject {
    func dismissViewController()
    func sendParametersData(data: MonitoringParametersSavedData)
}

final class SecondScreenMonitoringViewController: BaseController {
    
    // MARK: - Views
    
    private lazy var mainLabel: UILabel = {
        let lable = UILabel()
        lable.text = presenter.data.name
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 34)
        lable.textColor = .white
        return lable
    }()
    
    private lazy var trashImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "trash")
        image.isUserInteractionEnabled = true
        let gest = UITapGestureRecognizer(target: self, action: #selector(trashImageButtonTapped))
        image.addGestureRecognizer(gest)
        return image
    }()
    
    private lazy var pencilImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pencil")
        image.isUserInteractionEnabled = true
        let gest = UITapGestureRecognizer(target: self, action: #selector(pencilImageButtonTapped))
        image.addGestureRecognizer(gest)
        return image
    }()
    
    // MARK: - Properties
    
    private let presenter: SecondScreenMonitoringInput
    private let secondScreenParametersViews = SecondScreenParametersViews()
    
    // MARK: - Init
    
    init(presenter: SecondScreenMonitoringInput) {
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
}


// MARK: - Actions

private extension SecondScreenMonitoringViewController {
    @objc func trashImageButtonTapped() {
        let alertController = UIAlertController(title: "Deletion", message: "Do you really want to delete it?", preferredStyle: .alert)
        let action = UIAlertAction(title: "No", style: .default)
        let actionDelete = UIAlertAction(title: "Yes", style: .destructive) { action in
            self.deleteOneItem() }
        alertController.addAction(action)
        alertController.addAction(actionDelete)
        present(alertController, animated: true)
    }
    
    @objc func pencilImageButtonTapped() {
        print("Edit Activate")
    }
    
    func deleteOneItem() {
        presenter.deleteOneItem()
    }
}

// MARK: - Output

extension SecondScreenMonitoringViewController: SecondScreenMonitoringOutput {
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }

    func sendParametersData(data: MonitoringParametersSavedData) {
        secondScreenParametersViews.configure(data: data)
    }
}

// MARK: - Loyaut

private extension SecondScreenMonitoringViewController {
    
    func addSubviews() {
        view.addSubview(mainLabel)
        view.addSubview(trashImage)
        view.addSubview(pencilImage)
        view.addSubview(secondScreenParametersViews)
    }
    
    func makeConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
        }
        
        trashImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(20)
        }
        
        pencilImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(28)
            make.trailing.equalTo(trashImage.snp.leading).offset(-10)
        }
        
        secondScreenParametersViews.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width - 32)
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(30)
        }
    }
}

