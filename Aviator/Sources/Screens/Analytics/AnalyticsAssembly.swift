//
//  AnalyticsAssembly.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import Foundation

struct AnalyticsAssembly {
    
    static func build() -> AnalyticsViewController {
        let presenter = AnalyticsPresenter()
        let vc = AnalyticsViewController(presenter: presenter)
        presenter.viewController = vc
        return vc
    }
}
