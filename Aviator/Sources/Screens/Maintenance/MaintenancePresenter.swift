//
//  MaintenancePresenter.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import Foundation
import RealmSwift

// MARK: - Protocol

protocol MaintenanceInput {
    var maintenanceDataBase: [AircraftDataModel] { get }
    func setupBackgroundImage()
    func updateData()
}

final class MaintenancePresenter: MaintenanceInput {
    
    // MARK: - Properties
    
    weak var viewController: MaintenanceOutput?
    
    private let realm = try! Realm()
    private var itemsAircraftModel: Results<AircraftDataModel>!
    var maintenanceDataBase: [AircraftDataModel] = []
    
    // MARK: - Public function
    
    func updateData() {
        itemsAircraftModel = realm.objects(AircraftDataModel.self)
        maintenanceDataBase = Array(itemsAircraftModel)
    }
    
    func setupBackgroundImage() {
        if maintenanceDataBase.count == 0 {
            viewController?.setupBackgroundImage(parametr: false)
        } else {
            viewController?.setupBackgroundImage(parametr: true)
        }
    }
}
