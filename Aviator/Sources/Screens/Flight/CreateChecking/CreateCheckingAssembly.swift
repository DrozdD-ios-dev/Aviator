//
//  CreateCheckingAssembly.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import Foundation

struct CreateCheckingAssembly {
    
    static func build() -> CreateCheckingViewController {
        let presenter = CreateCheckingPresenter()
        let vc = CreateCheckingViewController(presenter: presenter)
        presenter.viewController = vc
        return vc
    }
}
