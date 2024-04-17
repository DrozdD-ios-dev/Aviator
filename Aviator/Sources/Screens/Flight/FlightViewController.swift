//
//  FlightViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import UIKit

// MARK: - Protocol

protocol FlightOutput: AnyObject {
    
}

final class FlightViewController: BaseController {
    
    // MARK: - Views
    
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
        view.backgroundColor = .systemGreen
    }
}

// MARK: - Actions

extension FlightViewController {
    
}

// MARK: - Output

extension FlightViewController: FlightOutput {
    
}
