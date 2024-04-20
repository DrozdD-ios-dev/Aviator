//
//  FirstScreenAircraftMaintenanceAssembly.swift
//  Aviator
//
//  Created by Дрозд Денис on 20.04.2024.
//

import Foundation

struct FirstScreenAircraftMaintenanceAssembly {
    
    static func build(data: AircraftDataModel, index: Int) -> FirstScreenAircraftMaintenanceViewController {
        let presenter = FirstScreenAircraftMaintenancePresenter(data: data, index: index)
        let vc = FirstScreenAircraftMaintenanceViewController(presenter: presenter)
        presenter.viewController = vc
        return vc
    }
}
