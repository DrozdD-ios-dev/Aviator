//
//  AnalyticsViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import UIKit

// MARK: - Protocol

protocol AnalyticsOutput: AnyObject {
    func setupBackgroundImage(parameter: Bool)
}

final class AnalyticsViewController: BaseController {
    
    // MARK: - Views
    
    private let navigationBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Red220")
        view.layer.cornerRadius = 50
        return view
    }()
    
    private let mainLable: UILabel = {
        let lable = UILabel()
        lable.text = "Analytics"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 34)
        lable.textColor = .white
        return lable
    }()
    
    private let analyticsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.isHidden = false
        return stack
    }()
    
    private let analyticsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "report")
        return image
    }()
    
    private let analyticsLable: UILabel = {
        let lable = UILabel()
        lable.text = "Reports"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 23)
        lable.textColor = .white
        lable.textAlignment = .center
        return lable
    }()
    
    private let analyticsLableDesc: UILabel = {
        let lable = UILabel()
        lable.text = "Your reports will be displayed\n here"
        lable.font = UIFont(name: EnumString.SFMed.rawValue, size: 17)
        lable.numberOfLines = 2
        lable.textColor = .gray
        lable.textAlignment = .center
        return lable
    }()
    
    private lazy var analyticsCollectionView: UICollectionView = {
        let loyout = UICollectionViewFlowLayout()
        loyout.scrollDirection = .vertical
        loyout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: loyout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(AnalyticsCell.self, forCellWithReuseIdentifier: AnalyticsCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Properties
    
    private let presenter: AnalyticsInput
    
    // MARK: - Init
    
    init(presenter: AnalyticsInput) {
        self.presenter = presenter
        super.init()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray43")
        addSubviews()
        makeConstraints()
        presenter.updateData()
        presenter.setupBackgroundImage()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataAnalyticsScreen), name: Notification.Name("UpdateAnalyticsReports"), object: nil)
    }
}

// MARK: - Actions

extension AnalyticsViewController {
 
    @objc func reloadDataAnalyticsScreen() {
        presenter.updateData()
        analyticsCollectionView.reloadData()
        presenter.setupBackgroundImage()
    }
    
}

// MARK: - Output

extension AnalyticsViewController: AnalyticsOutput {
    func setupBackgroundImage(parameter: Bool) {
        analyticsStack.isHidden = parameter
    }
}

// MARK: - Layout
extension AnalyticsViewController {
    
    func addSubviews() {
        view.addSubview(navigationBarView)
        navigationBarView.addSubview(mainLable)
        view.addSubview(analyticsStack)
        analyticsStack.addArrangedSubview(analyticsImage)
        analyticsStack.addArrangedSubview(analyticsLable)
        analyticsStack.addArrangedSubview(analyticsLableDesc)
        view.addSubview(analyticsCollectionView)
        
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
        
        analyticsStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        analyticsLableDesc.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        analyticsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.horizontalEdges.equalToSuperview()
        }
    }
}

// MARK: - CollectionView DataSource

extension AnalyticsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.verificationDataBase.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnalyticsCell.identifier, for: indexPath) as! AnalyticsCell
        cell.configure(with: presenter.verificationDataBase[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 33, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = presenter.verificationDataBase[indexPath.item]
        let vc = AnalyticsExtraScreenAssembly.build(data: data, index: indexPath.item)
        navigationController?.present(vc, animated: true)
    }
}
