//
//  ExtraSettingsMonitoringViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 18.04.2024.
//

import Foundation
import RealmSwift

// MARK: - Protocol

protocol ExtraSettingsMaintenanceInput {
    func updateNameAircraft(text: String)
    func updateModelAircraft(text: String)
    func updateSerialNumberAircraft(text: String)
    func datePickerValueChanged(text: String)
    func processButtonActions()
    
}

final class ExtraSettingsMaintenancePresenter: ExtraSettingsMaintenanceInput {
    
    // MARK: - Properties
    
    weak var viewController: ExtraSettingsMaintenanceOutput?
    
    private let realm = try! Realm()
    private var itemsAircraftModel: Results<AircraftDataModel>!
    
    private var dataAircraft = MaintenanceDataAircraft(
        name: "",
        model: "",
        serialNumber: "",
        lastInspection: "",
        upcomingInspection: "")
    
    // MARK: - Private func
    
    private func saveDataToRealm() {
        let data = AircraftDataModel()
        data.name = dataAircraft.name
        data.model = dataAircraft.model
        data.serialNumber = dataAircraft.serialNumber
        data.lastInspection = dataAircraft.lastInspection
        data.upcomingInspection = dataAircraft.upcomingInspection
        
        try! realm.write {
            realm.add([data])
        }
        NotificationCenter.default.post(name: Notification.Name("Update"), object: nil)
    }
    
    // MARK: - Public func
    
    func processButtonActions() {
        if dataAircraft.name != "" && dataAircraft.model != "" && dataAircraft.serialNumber != "" && dataAircraft.lastInspection != "" && dataAircraft.upcomingInspection != ""  {
            viewController?.dismissViewController()
            saveDataToRealm()
        } else {
            viewController?.showAlert()
            NotificationCenter.default.post(name: Notification.Name("Update"), object: nil)
        }
    }
    
    func updateNameAircraft(text: String) {
        dataAircraft.name = text
    }
    
    func updateModelAircraft(text: String) {
        dataAircraft.model = text
    }
    
    func updateSerialNumberAircraft(text: String) {
        dataAircraft.serialNumber = text
    }
    
    func datePickerValueChanged(text: String) {
        if dataAircraft.lastInspection == "" {
            dataAircraft.lastInspection = text
            viewController?.updateTextfields(textFieldOne: text, textFieldTwo: nil)
        } else if dataAircraft.upcomingInspection == "" {
            dataAircraft.upcomingInspection = text
            viewController?.updateTextfields(textFieldOne: nil, textFieldTwo: text)
        }
    }
}
