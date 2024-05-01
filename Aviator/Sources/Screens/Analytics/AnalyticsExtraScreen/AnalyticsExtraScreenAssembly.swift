//
//  AnalyticsExtraScreenAssembly.swift
//  Aviator
//
//  Created by Дрозд Денис on 25.04.2024.
//

import Foundation

struct AnalyticsExtraScreenAssembly {
    
    static func build(data: VerificationCheckingSaveData, index: Int) -> AnalyticsExtraScreenViewController {
        let presenter = AnalyticsExtraScreenPresenter(data: data, index: index)
        let vc = AnalyticsExtraScreenViewController(presenter: presenter)
        presenter.viewController = vc
        return vc
    }
}
