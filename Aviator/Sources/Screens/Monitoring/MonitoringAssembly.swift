//
//  MonitoringAssembly.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import Foundation

struct MonitoringAssembly {
    
    static func build() -> MonitoringViewController {
            let presenter = MonitoringPresenter()
            let vc = MonitoringViewController(presenter: presenter)
            presenter.viewController = vc
            return vc
        }
    }

