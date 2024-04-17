//
//  FlightAssembly.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import Foundation

struct FlightAssembly {
    
    static func build() -> FlightViewController {
        let presenter = FlightPresenter()
        let vc = FlightViewController(presenter: presenter)
        presenter.viewController = vc
        return vc
    }
}
