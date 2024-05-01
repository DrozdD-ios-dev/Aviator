//
//  FlightViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import UIKit

// MARK: - Protocol

protocol FlightOutput: AnyObject {
    func setupBackgroundImage(parameter: Bool)
}

final class FlightViewController: BaseController {
    
    // MARK: - Views
    
    private let navigationBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Red220")
        view.layer.cornerRadius = 50
        return view
    }()
    
    private let mainLable: UILabel = {
        let lable = UILabel()
        lable.text = "Flight"
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
    
    private let checkingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "checkTicket")
        return image
    }()
    
    private let checkingLable: UILabel = {
        let lable = UILabel()
        lable.text = "Nearest flights"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 23)
        lable.textColor = .white
        lable.textAlignment = .center
        return lable
    }()
    
    private let checkingLableDesc: UILabel = {
        let lable = UILabel()
        lable.text = "Fill out the nearest flight to\n check the aircraft"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 17)
        lable.numberOfLines = 2
        lable.textColor = .gray
        lable.textAlignment = .center
        return lable
    }()
    
    private lazy var checkingCollectionView: UICollectionView = {
        let loyout = UICollectionViewFlowLayout()
        loyout.scrollDirection = .vertical
        loyout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: loyout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(FlightCell.self, forCellWithReuseIdentifier: FlightCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var createCheckingButton: BaseButton = {
        let button = BaseButton(text: "Add nearest flights")
        button.addAction(UIAction {_ in self.createCheckingButtonTapped()}, for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private let presenter: FlightInput
    // MARK: - Init
    
    init(presenter: FlightInput) {
        self.presenter = presenter
        super.init()
    }
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray43")
        addSubviews()
        makeConstraints()
        presenter.updateData()
        presenter.setupBackgroundImage()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataSecondScreen), name: Notification.Name("UpdateChecking"), object: nil)
    }
}

// MARK: - Actions

extension FlightViewController {
    
    func createCheckingButtonTapped() {
        let vc = CreateCheckingAssembly.build()
        navigationController?.present(vc, animated: true)
    }
    
    @objc func reloadDataSecondScreen() {
        presenter.updateData()
        checkingCollectionView.reloadData()
        presenter.setupBackgroundImage()
    }
}

// MARK: - Output

extension FlightViewController: FlightOutput {
    func setupBackgroundImage(parameter: Bool) {
        monitoringStack.isHidden = parameter
    }
}

// MARK: - Layout
extension FlightViewController {
    
    func addSubviews() {
        view.addSubview(navigationBarView)
        navigationBarView.addSubview(mainLable)
        view.addSubview(monitoringStack)
        monitoringStack.addArrangedSubview(checkingImage)
        monitoringStack.addArrangedSubview(checkingLable)
        monitoringStack.addArrangedSubview(checkingLableDesc)
        view.addSubview(checkingCollectionView)
        view.addSubview(createCheckingButton)
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
        
        checkingLableDesc.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        checkingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom).offset(16)
            make.bottom.equalTo(createCheckingButton.snp.top).offset(-16)
            make.horizontalEdges.equalToSuperview()
        }
        
        createCheckingButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

// MARK: - CollectionView DataSource

extension FlightViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.flightDataBase.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlightCell.identifier, for: indexPath) as! FlightCell
        cell.configure(with: presenter.flightDataBase[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 33, height: 100) 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = presenter.flightDataBase[indexPath.item]
        let vc = ThirdScreenFlightAssembly.build(data: data, index: indexPath.item)
        navigationController?.present(vc, animated: true)
    }
}
