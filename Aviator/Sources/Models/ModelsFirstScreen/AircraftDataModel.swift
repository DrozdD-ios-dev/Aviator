//
//  AircraftDataModel.swift
//  Aviator
//
//  Created by Дрозд Денис on 19.04.2024.
//

import Foundation
import RealmSwift

class AircraftDataModel: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var model: String = ""
    @objc dynamic var serialNumber: String = ""
    @objc dynamic var lastInspection: String = ""
    @objc dynamic var upcomingInspection: String = ""
}
