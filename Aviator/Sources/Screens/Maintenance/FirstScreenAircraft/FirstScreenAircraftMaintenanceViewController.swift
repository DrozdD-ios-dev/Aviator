//
//  ScreenOneAircraftMaintenanceViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 20.04.2024.
//

import UIKit

// MARK: - Protocol

protocol FirstScreenAircraftMaintenanceOutput: AnyObject {
    func dismissViewController()
    func sendInspectionData(data: AircraftDataModel)
}

final class FirstScreenAircraftMaintenanceViewController: BaseController {
    
    // MARK: - Views
    
    private lazy var mainLabel: UILabel = {
        let lable = UILabel()
        lable.text = presenter.data.name
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 34)
        lable.textColor = .white
        return lable
    }()
    
    private let aircraftScreenOneImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "aircraftScreenOne")
        return image
    }()
    
    private lazy var trashImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "trash")
        image.isUserInteractionEnabled = true
        let gest = UITapGestureRecognizer(target: self, action: #selector(trashImageButtonTapped))
        image.addGestureRecognizer(gest)
        return image
    }()
    
    private let redLineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(named: "Red239")
        return line
    }()
    
    // MARK: - Properties
    
    private let presenter: FirstScreenMaintenanceAircraftInput
    private let firstScreenInspectionView = FirstScreenInspectionView()
    
    // MARK: - Init
    
    init(presenter: FirstScreenMaintenanceAircraftInput) {
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

private extension FirstScreenAircraftMaintenanceViewController {
    @objc func trashImageButtonTapped() {
        presenter.deleteOneItem()
    }
}

// MARK: - Output

extension FirstScreenAircraftMaintenanceViewController: FirstScreenAircraftMaintenanceOutput {
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }

    func sendInspectionData(data: AircraftDataModel) {
        firstScreenInspectionView.configure(data: data)
    }
}

// MARK: - Loyaut

private extension FirstScreenAircraftMaintenanceViewController {
    
    func addSubviews() {
        view.addSubview(mainLabel)
        view.addSubview(aircraftScreenOneImage)
        view.addSubview(trashImage)
        view.addSubview(redLineView)
        view.addSubview(firstScreenInspectionView)
    }
    
    func makeConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
        }
        
        aircraftScreenOneImage.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(mainLabel.snp.bottom).offset(16)
        }
        
        trashImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(20)
        }
        
        redLineView.snp.makeConstraints { make in
            make.top.equalTo(aircraftScreenOneImage.snp.bottom).offset(40)
            make.height.equalTo(2)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        firstScreenInspectionView.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width - 32)
            make.centerX.equalToSuperview()
            make.top.equalTo(redLineView.snp.bottom).offset(30)
        }
    }
}
