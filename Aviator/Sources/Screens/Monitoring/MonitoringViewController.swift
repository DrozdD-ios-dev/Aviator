//
//  MonitoringViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import UIKit

// MARK: - Protocol

protocol MonitoringOutput: AnyObject {
    
}

final class MonitoringViewController: BaseController {
    
    // MARK: - Views
    
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
        view.backgroundColor = .white
    }
}

// MARK: - Actions

extension MonitoringViewController {
    
}

// MARK: - Output

extension MonitoringViewController: MonitoringOutput {
    
}
