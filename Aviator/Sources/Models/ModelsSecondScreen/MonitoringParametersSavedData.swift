//
//  MonitoringParametersSavedData.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import Foundation
import RealmSwift

class MonitoringParametersSavedData: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var weight: String = ""
    @objc dynamic var balanceStatus: Bool = false
    @objc dynamic var engineTemp: String = ""
    @objc dynamic var airPressure: String = ""
    @objc dynamic var fuelConsumption: String = ""
}
