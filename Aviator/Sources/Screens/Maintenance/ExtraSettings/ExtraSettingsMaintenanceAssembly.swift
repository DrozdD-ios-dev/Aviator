//
//  ExtraSettingsMaintenanceAssembly.swift
//  Aviator
//
//  Created by Дрозд Денис on 18.04.2024.
//

import Foundation

struct ExtraSettingsMaintenanceAssembly {
    
    static func build() -> ExtraSettingsMaintenanceViewController {
        let presenter = ExtraSettingsMaintenancePresenter()
        let vc = ExtraSettingsMaintenanceViewController(presenter: presenter)
        presenter.viewController = vc
        return vc
    }
}
