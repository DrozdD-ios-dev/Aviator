//
//  AnalyticsExtraScreenViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 25.04.2024.
//

import UIKit

// MARK: - Protocol

protocol AnalyticsExtraScreenOutput: AnyObject {
    func dismissViewController()
    func sendParametersData(data: VerificationCheckingSaveData)
}

final class AnalyticsExtraScreenViewController: BaseController {
    
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
    
    // MARK: - Properties
    
    private let presenter: AnalyticsExtraScreenInput
    private let analyticsScreenParametersViews = AnalyticsScreenParameters()
    
    // MARK: - Init
    
    init(presenter: AnalyticsExtraScreenInput) {
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

private extension AnalyticsExtraScreenViewController {
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

extension AnalyticsExtraScreenViewController: AnalyticsExtraScreenOutput {
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }

    func sendParametersData(data: VerificationCheckingSaveData) {
        analyticsScreenParametersViews.configure(data: data)
    }
}

// MARK: - Loyaut

private extension AnalyticsExtraScreenViewController {
    
    func addSubviews() {
        view.addSubview(mainLabel)
        view.addSubview(trashImage)
        view.addSubview(analyticsScreenParametersViews)
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
        
        analyticsScreenParametersViews.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width - 32)
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(30)
        }
    }
}


