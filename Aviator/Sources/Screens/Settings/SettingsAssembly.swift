//
//  SettingsAssembly.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import Foundation

struct SettingsAssembly {
    
    static func build() -> SettingsViewController {
        let presenter = SettingsPresenter()
        let vc = SettingsViewController(presenter: presenter)
        presenter.viewController = vc
        return vc
    }
}
