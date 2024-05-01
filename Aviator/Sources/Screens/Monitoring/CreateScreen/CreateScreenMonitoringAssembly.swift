//
//  CreateScreenMonitoringAssembly.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import Foundation

struct CreateScreenMonitoringAssembly {
    
    static func build() -> CreateScreenMonitoringViewController {
        let presenter = CreateScreenMonitoringPresenter()
        let vc = CreateScreenMonitoringViewController(presenter: presenter)
        presenter.viewController = vc
        return vc
    }
}
