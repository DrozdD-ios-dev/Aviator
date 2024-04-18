//
//  ExtraSettingsMonitoringViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 18.04.2024.
//

import Foundation

// MARK: - Protocol

protocol ExtraSettingsMaintenanceInput {
    func updateNameAircraft(text: String)
    func updateModelAircraft(text: String)
    func updateSerialNumberAircraft(text: String)
//    func updateLastInspectionAircraft(text: String)
//    func updateUpcomingInspectionAircraft(text: String)
    func datePickerValueChanged(text: String)
    func processButtonActions()
    
}

final class ExtraSettingsMaintenancePresenter: ExtraSettingsMaintenanceInput {
    
    // MARK: - Properties
    
    weak var viewController: ExtraSettingsMaintenanceOutput?
    
    private var dataAircraft = MaintenanceDataAircraft(
        name: "",
        model: "",
        serialNumber: "",
        lastInspection: "",
        upcomingInspection: "")
    
    // MARK: - Init 
    
    // MARK: - Public func
    
    func processButtonActions() {
        if dataAircraft.name != "" && dataAircraft.model != "" && dataAircraft.serialNumber != "" && dataAircraft.lastInspection != "" && dataAircraft.upcomingInspection != ""  {
            viewController?.dismissViewController()
        } else {
            viewController?.showAlert()
        }
    }
    
    func updateNameAircraft(text: String) {
        dataAircraft.name = text
        print(text)
    }
    
    func updateModelAircraft(text: String) {
        dataAircraft.model = text
        print(text)
    }
    
    func updateSerialNumberAircraft(text: String) {
        dataAircraft.serialNumber = text
        print(text)
    }
    
//    func updateLastInspectionAircraft(text: String) {
//        dataAircraft.lastInspection = text
//        print(text)
//    }
//    
//    func updateUpcomingInspectionAircraft(text: String) {
//        dataAircraft.upcomingInspection = text
//        print(text)
//    }
    
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


//if lastDataTextField.text == "Select last date" {
//    lastDataTextField.text = formatter.string(from: sender.date)
//    presenter.updateLastInspectionAircraft(text: formatter.string(from: sender.date))
//} else if upcomingDataTextField.text == "Select upcoming date" {
//    upcomingDataTextField.text = formatter.string(from: sender.date)
//    presenter.updateUpcomingInspectionAircraft(text: formatter.string(from: sender.date))
//}
