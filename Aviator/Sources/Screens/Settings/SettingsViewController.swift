//
//  SettingsViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import UIKit

// MARK: - Protocol

protocol SettingsOutput: AnyObject {
    
}

final class SettingsViewController: BaseController {
    
    // MARK: - Views
    
    // MARK: - Properties
    
    private let presenter: SettingsInput
    
    // MARK: - Init
    
    init(presenter: SettingsInput) {
        self.presenter = presenter
        super.init()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}

// MARK: - Actions

extension SettingsViewController {
    
}

// MARK: - Output

extension SettingsViewController: SettingsOutput {
    
}
