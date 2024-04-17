//
//  AnalyticsViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import UIKit

// MARK: - Protocol

protocol AnalyticsOutput: AnyObject {
    
}

final class AnalyticsViewController: BaseController {
    
    // MARK: - Views
    
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
        view.backgroundColor = .systemBlue
        
    }
}

// MARK: - Actions

extension AnalyticsViewController {
    
}

// MARK: - Output

extension AnalyticsViewController: AnalyticsOutput {
    
}
