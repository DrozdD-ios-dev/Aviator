//
//  StartAssembly.swift
//  Aviator
//
//  Created by Дрозд Денис on 25.04.2024.
//

import Foundation

struct StartAssembly {
    
    static func build() -> StartVievController {
        let presenter = StartPresenter()
        let vc = StartVievController(presenter: presenter)
        presenter.viewController = vc
        return vc
    }
}
