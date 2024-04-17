//
//  MaintenanceAssembly.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import Foundation

struct MaintenanceAssembly {
    
    static func build() -> MaintenanceViewController {
        let presenter = MaintenancePresenter()
        let vc = MaintenanceViewController(presenter: presenter)
        presenter.viewController = vc 
        return vc
    }
}
