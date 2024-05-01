//
//  VerificationCheckingSaveData.swift
//  Aviator
//
//  Created by Дрозд Денис on 25.04.2024.
//

import Foundation
import RealmSwift

class VerificationCheckingSaveData: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var systemComponents: Bool = false
    @objc dynamic var electronics: Bool = false
    @objc dynamic var identification: Bool = false
    @objc dynamic var notes: String = ""
}
