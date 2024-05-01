//
//  FlightCheckingSaveData.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import Foundation
import RealmSwift

class FlightCheckingSaveData: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var checkingDate: String = ""
}
