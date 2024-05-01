//
//  CreateScreenMonitoringPresenter.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import Foundation
import RealmSwift

// MARK: - Protocol

protocol CreateScreenMonitoringInput {
    func updateNameParameters(text: String)
    func updateWeightParameters(text: String)
    func updateStatusButton(status: Bool)
    func updateEngineTempParameters(text: String)
    func updateAirPressureParameters(text: String)
    func updateFuelConsumptionParameters(text: String)
    func processButtonActions()
    var dataParameters: MonitoringDataParameters { get }
}

final class CreateScreenMonitoringPresenter: CreateScreenMonitoringInput {
    
    // MARK: - Properties
    
    weak var viewController: CreateScreenMonitoringOutput?
    
    private let realm = try! Realm()
    private var itemsAircraftModel: Results<MonitoringParametersSavedData>!
    
    var dataParameters = MonitoringDataParameters(
        name: "",
        weight: "",
        balanceStatus: false,
        engineTemp: "",
        airPressure: "",
        fuelConsumption: "")
    
    // MARK: - Private func
    
    private func saveDataToRealm() {
        let data = MonitoringParametersSavedData()
        data.name = dataParameters.name
        data.weight = dataParameters.weight
        data.balanceStatus = dataParameters.balanceStatus
        data.engineTemp = dataParameters.engineTemp
        data.airPressure = dataParameters.airPressure
        data.fuelConsumption = dataParameters.fuelConsumption
        
        try! realm.write {
            realm.add([data])
        }
        NotificationCenter.default.post(name: Notification.Name("UpdateParameters"), object: nil)
    }
    
    // MARK: - Public func
    
    func processButtonActions() {
        if dataParameters.name != "" && dataParameters.weight != "" && dataParameters.engineTemp != "" && dataParameters.airPressure != "" && dataParameters.fuelConsumption != ""  {
            viewController?.dismissViewController()
            saveDataToRealm()
        } else {
            viewController?.showAlert()
        }
    }
    
    func updateNameParameters(text: String) {
        dataParameters.name = text
    }
    
    func updateWeightParameters(text: String) {
        dataParameters.weight = text + " kg"
    }
    
    func updateStatusButton(status: Bool) {
        dataParameters.balanceStatus = status
    }
    
    func updateEngineTempParameters(text: String) {
        dataParameters.engineTemp = text + " °C"
    }
    
    func updateAirPressureParameters(text: String) {
        dataParameters.airPressure = text + " GPa"
    }
    
    func updateFuelConsumptionParameters(text: String) {
        dataParameters.fuelConsumption = text + " g/pass-km"
    }
}
