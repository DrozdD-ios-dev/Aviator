//
//  ThirdScreenFlightAssembly.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import Foundation

struct ThirdScreenFlightAssembly {
    
    static func build(data: FlightCheckingSaveData, index: Int) -> ThirdScreenFlightViewController {
        let presenter = ThirdScreenFlightPresenter(data: data, index: index)
        let vc = ThirdScreenFlightViewController(presenter: presenter)
        presenter.viewController = vc
        return vc
    }
}
