//
//  MonitoringViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import UIKit

// MARK: - Protocol

protocol MonitoringOutput: AnyObject {
    func setupBackgroundImage(parameter: Bool)
}

final class MonitoringViewController: BaseController {
    
    // MARK: - Views
    
    private let navigationBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Red220")
        view.layer.cornerRadius = 50
        return view
    }()
    
    private let mainLable: UILabel = {
        let lable = UILabel()
        lable.text = "Monitoring"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 34)
        lable.textColor = .white
        return lable
    }()
    
    private let monitoringStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.isHidden = false
        return stack
    }()
    
    private let monitoringImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "monitoring")
        return image
    }()
    
    private let monitoringLable: UILabel = {
        let lable = UILabel()
        lable.text = "Monitoring of \n parameters"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 23)
        lable.textColor = .white
        lable.numberOfLines = 2
        lable.textAlignment = .center
        return lable
    }()
    
    private let monitoringLableDesc: UILabel = {
        let lable = UILabel()
        lable.text = "Track all aircraft parameters"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 17)
        lable.textColor = .gray
        return lable
    }()
    
    private lazy var monitoringCollectionView: UICollectionView = {
        let loyout = UICollectionViewFlowLayout()
        loyout.scrollDirection = .vertical
        loyout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: loyout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(MonitoringCell.self, forCellWithReuseIdentifier: MonitoringCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var createParametersButton: BaseButton = {
        let button = BaseButton(text: "Add monitoring of parameters")
        button.addAction(UIAction {_ in self.createMonitoringButtonTapped()}, for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private let presenter: MonitoringInput
    
    // MARK: - Init
    
    init(presenter: MonitoringInput) {
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
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataSecondScreen), name: Notification.Name("UpdateParameters"), object: nil)
    }
}

// MARK: - Actions

extension MonitoringViewController {
    
    func createMonitoringButtonTapped() {
        let vc = CreateScreenMonitoringAssembly.build()
        navigationController?.present(vc, animated: true)
    }
    
    @objc func reloadDataSecondScreen() {
        presenter.updateData()
        monitoringCollectionView.reloadData()
        presenter.setupBackgroundImage()
    }
}

// MARK: - Output

extension MonitoringViewController: MonitoringOutput {
    func setupBackgroundImage(parameter: Bool) {
        monitoringStack.isHidden = parameter
    }
}

// MARK: - Layout
extension MonitoringViewController {
    
    func addSubviews() {
        view.addSubview(navigationBarView)
        navigationBarView.addSubview(mainLable)
        view.addSubview(monitoringStack)
        monitoringStack.addArrangedSubview(monitoringImage)
        monitoringStack.addArrangedSubview(monitoringLable)
        monitoringStack.addArrangedSubview(monitoringLableDesc)
        view.addSubview(monitoringCollectionView)
        view.addSubview(createParametersButton)
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
        
        monitoringStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        monitoringCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom).offset(16)
            make.bottom.equalTo(createParametersButton.snp.top).offset(-16)
            make.horizontalEdges.equalToSuperview()
        }
        
        createParametersButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

// MARK: - CollectionView DataSource

extension MonitoringViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.monitoringDataBase.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonitoringCell.identifier, for: indexPath) as! MonitoringCell
        cell.configure(with: presenter.monitoringDataBase[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 33, height: 65) // ??
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = presenter.monitoringDataBase[indexPath.item]
        let vc = SecondScreenMonitoringAssembly.build(data: data, index: indexPath.item)
        navigationController?.present(vc, animated: true)
    }
}
