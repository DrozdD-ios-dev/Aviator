//
//  MaintenancePresenter.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import Foundation

// MARK: - Protocol

protocol MaintenanceInput {
    func printOne()
}

final class MaintenancePresenter: MaintenanceInput {
    
    // MARK: - Properties
    
    weak var viewController: MaintenanceOutput?
    
    // MARK: - Init
    
    // MARK: - Public function
    
    func printOne() {
        print("One")
    }
}
