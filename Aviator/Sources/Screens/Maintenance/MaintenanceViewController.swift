//
//  MaintenanceViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//


import UIKit

// MARK: - Protocol

protocol MaintenanceOutput: AnyObject {
    func setupBackgroundImage(parametr: Bool)
}

final class MaintenanceViewController: BaseController {
    
    // MARK: - Views
    
    private let navigationBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Red220")
        view.layer.cornerRadius = 50
        return view
    }()
    
    private let mainMaintenanceLable: UILabel = {
        let lable = UILabel()
        lable.text = "Maintenance"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 34)
        lable.textColor = .white
        return lable
    }()
    
    private let aircraftMaintenanceStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.isHidden = true
        return stack
    }()
    
    private let aircraftMaintenanceImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "airPlan")
        return image
    }()
    
    private let aircraftMaintenanceLable: UILabel = {
        let lable = UILabel()
        lable.text = "Aircraft"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 23)
        lable.textColor = .white
        return lable
    }()
    
    private let aircraftMaintenanceLableDesc: UILabel = {
        let lable = UILabel()
        lable.text = "Add your aircraft for maintenance"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 17)
        lable.textColor = .gray
        return lable
    }()
    
    private lazy var aircraftCollectionView: UICollectionView = {
        let loyout = UICollectionViewFlowLayout()
        loyout.scrollDirection = .vertical
        loyout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: loyout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(MaintenanceCell.self, forCellWithReuseIdentifier: MaintenanceCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var aircraftMaintenanceButton: BaseButton = {
        let button = BaseButton(text: "Create aircraft")
        button.addAction(UIAction {_ in self.createAircraftButtonTapped()}, for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private let presenter: MaintenanceInput
    
    // MARK: - Init
    
    init(presenter: MaintenanceInput) {
        self.presenter = presenter
        super.init()
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray43")
        addSubviews()
        makeConstraints()
        presenter.updateData()
        presenter.setupBackgroundImage()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("Update"), object: nil)
    }
}

// MARK: - Actions

private extension MaintenanceViewController {
    
    func createAircraftButtonTapped() {
        let vc = ExtraSettingsMaintenanceAssembly.build()
        navigationController?.present(vc, animated: true)
    }
    
    @objc func reloadData() {
        presenter.updateData()
        aircraftCollectionView.reloadData()
        presenter.setupBackgroundImage()
    }
}

// MARK: - Output

extension MaintenanceViewController: MaintenanceOutput {
    func setupBackgroundImage(parametr: Bool) {
        aircraftMaintenanceStack.isHidden = parametr
    }
    
    
}

// MARK: - Layout

private extension MaintenanceViewController {
    
    func addSubviews() {
        view.addSubview(navigationBarView)
        navigationBarView.addSubview(mainMaintenanceLable)
        view.addSubview(aircraftMaintenanceStack)
        aircraftMaintenanceStack.addArrangedSubview(aircraftMaintenanceImage)
        aircraftMaintenanceStack.addArrangedSubview(aircraftMaintenanceLable)
        aircraftMaintenanceStack.addArrangedSubview(aircraftMaintenanceLableDesc)
        view.addSubview(aircraftCollectionView)
        view.addSubview(aircraftMaintenanceButton)
    }
    
    func makeConstraints() {
        navigationBarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(view.frame.height * 0.15)
            make.width.equalTo(view.frame.width * 2)
        }
        
        mainMaintenanceLable.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview().inset(16)
        }
        
        aircraftMaintenanceStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        aircraftCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom).offset(16)
            make.bottom.equalTo(aircraftMaintenanceButton.snp.top).offset(-16)
            make.horizontalEdges.equalToSuperview()
        }
        
        aircraftMaintenanceButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

// MARK: - CollectionView DataSource

extension MaintenanceViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.maintenanceDataBase.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MaintenanceCell.identifier, for: indexPath) as! MaintenanceCell
        cell.configure(with: presenter.maintenanceDataBase[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 33, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = presenter.maintenanceDataBase[indexPath.item]
        let vc = FirstScreenAircraftMaintenanceAssembly.build(data: data, index: indexPath.item)
        navigationController?.present(vc, animated: true)
    }
}
