//
//  SecondScreenMonitoringAssembly.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import Foundation

struct SecondScreenMonitoringAssembly {
    
    static func build(data: MonitoringParametersSavedData, index: Int) -> SecondScreenMonitoringViewController {
        let presenter = SecondScreenMonitoringPresenter(data: data, index: index)
        let vc = SecondScreenMonitoringViewController(presenter: presenter)
        presenter.viewController = vc
        return vc
    }
}
