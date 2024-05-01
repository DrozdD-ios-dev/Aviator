//
//  StartVievController.swift
//  Aviator
//
//  Created by Дрозд Денис on 25.04.2024.
//

import UIKit
import StoreKit

// MARK: - Protocol

protocol StartOutput: AnyObject {
    
}

final class StartVievController: BaseController {
    
    // MARK: - Views
    
    private lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "mainAircraft")
        image.isHidden = false
        return image
    }()
    
    private let progressStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        stack.isHidden = false
        return stack
    }()
    
    private let progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.trackTintColor = UIColor(named: "Gray62") ?? .gray
        progressBar.progressTintColor = UIColor(named: "Red220") ?? .red
        progressBar.layer.cornerRadius = 30
        progressBar.progress = 0.10
        return progressBar
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "0%"
        label.font = UIFont(name: EnumString.SFMed.rawValue, size: 14)
        return label
    }()
    
    private lazy var startScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.backgroundColor = .black
        scrollView.isHidden = true
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(images.count),
                                        height: view.frame.height)
        scrollView.isScrollEnabled = false
        return scrollView
    }()

    // MARK: - Properties
    
    private let presenter: StartInput
    private var progress: Float = 0
    private var timer: Timer?
    private var firstOpenApp: Bool = UserDefaults.standard.bool(forKey: "FirstOpenApp")
    private let images = [UIImage(named: "IMG1"), UIImage(named: "IMG2"), UIImage(named: "IMG3")]
    private var currentImageIndex = 1
    
    // MARK: - Init
    
    init(presenter: StartInput) {
        self.presenter = presenter
        super.init()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray43")
        addSubviews()
        makeConstraints()
        startTimer()
        setupWelcomeView()
    }
    
    // MARK: - Private func

   private func setupWelcomeView() {
         var indexThirdButton = 0
         let startLabelTexts = ["Rise to the clouds", "Rate our app in the AppStore", "Don't miss anything"]
         let startDescriptionTexts = ["At the speed of light", "Every day will be profitable", "Will send all important notifications on time"]
        for (index, image) in images.enumerated() {
            let imageView = UIImageView(image: image)
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleToFill
            imageView.frame = CGRect(x: CGFloat(index) * view.bounds.width,
                                     y: 0,
                                     width: view.bounds.width,
                                     height: view.bounds.height)
            
            let label = UILabel()
            label.text = startLabelTexts[index]
            label.textAlignment = .left
            label.textColor = .white
            label.numberOfLines = 10
            label.font = UIFont(name: EnumString.SFMed.rawValue, size: 22)
            label.frame = CGRect(x: view.bounds.width * 0.05,
                                 y: view.bounds.height * 0.75,
                                 width: view.bounds.width,
                                 height: 50)
            
            let labelDesc = UILabel()
            labelDesc.text = startDescriptionTexts[index]
            labelDesc.textAlignment = .left
            labelDesc.textColor = .gray
            labelDesc.numberOfLines = 10
            labelDesc.font = UIFont(name: EnumString.SFMed.rawValue, size: 17)
            labelDesc.frame = CGRect(x: view.bounds.width * 0.05,
                                     y: view.bounds.height * 0.78,
                                     width: view.bounds.width,
                                     height: 50)
            
            var button = BaseButton(text: "Next")
            if indexThirdButton < 2 {
                indexThirdButton += 1
                button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
                button.frame = CGRect(x: view.bounds.width * 0.5,
                                      y: view.bounds.height * 0.85,
                                      width: view.bounds.width * 0.45,
                                      height: 50)
            } else {
                let buttonNotification = BaseButton(text: "Enable notification")
                buttonNotification.addTarget(self, action: #selector(enableNotificationsButtonTapped), for: .touchUpInside)
                buttonNotification.frame = CGRect(x: view.bounds.width / 24,
                                                  y: view.bounds.height * 0.85,
                                                  width: view.bounds.width - 33,
                                                  height: 50)
                let buttonExite = UIImageView()
                buttonExite.image = UIImage(named: "exit")
                buttonExite.isUserInteractionEnabled = true
                let gest = UITapGestureRecognizer(target: self, action: #selector(nextScreenButtonTapped))
                buttonExite.addGestureRecognizer(gest)
                buttonExite.frame = CGRect(x: view.bounds.width - 40 ,
                                           y: view.bounds.height * 0.1,
                                           width: 30,
                                           height: 30)
                imageView.addSubview(buttonExite)
                button = buttonNotification
            }
            
            imageView.addSubview(labelDesc)
            imageView.addSubview(button)
            imageView.addSubview(label)
            startScrollView.addSubview(imageView)
        }
    }
    
    private func showProgress() {
        DispatchQueue.main.async {
            self.progress += 0.03
            self.progressBar.setProgress((self.progress), animated: true)
            self.progressLabel.text = "\(Int(self.progressBar.progress * 100))%"
            if self.progressBar.progress == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.nextScreen()
                })
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    @objc private func updateTime() {
        if progressBar.progress < 1 {
            showProgress()
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    private func nextScreen() {
        if firstOpenApp {
        let vc = MainTabBarViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        } else {
            progressStack.isHidden = true
            mainImage.isHidden = true
            startScrollView.isHidden = false
        }
    }
    
}

// MARK: - Actions

private extension StartVievController {

    @objc func nextScreenButtonTapped() {
        let vc = MainTabBarViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func enableNotificationsButtonTapped () {
        print("Enable Notifications")
    }
    
    @objc func nextButtonTapped () {
        if currentImageIndex == 1 {
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            }
        }
        
        let nextImageOffset = CGPoint(x: Int(view.frame.width) * currentImageIndex, y: 0)
        startScrollView.setContentOffset(nextImageOffset, animated: true)
        currentImageIndex += 1
    }
}

// MARK: - Output

extension StartVievController: StartOutput {
    
}

// MARK: - Layout

private extension StartVievController {
    
    func addSubviews() {
        view.addSubview(mainImage)
        view.addSubview(progressStack)
        progressStack.addArrangedSubview(progressBar)
        progressStack.addArrangedSubview(progressLabel)
        view.addSubview(startScrollView)
    }
    
    func makeConstraints() {
        mainImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        progressStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
        }
        progressBar.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width/2)
            make.height.equalTo(8)
        }
        
        startScrollView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
    }
}
