//
//  CreateCheckingPresenter.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import Foundation
import RealmSwift

// MARK: - Protocol

protocol CreateCheckingInput {
    func datePickerValueChanged(text: String) 
    func updateNameParameters(text: String)
    func processButtonActions()
}

final class CreateCheckingPresenter: CreateCheckingInput {
    
    // MARK: - Properties
    
    weak var viewController: CreateCheckingOutput?
    
    private let realm = try! Realm()
    private var itemsAircraftModel: Results<FlightCheckingSaveData>!
    
    var dataChecking = FlightCheckingData(name: "", checkingDate: "")
    
    // MARK: - Private func
    
    private func saveDataToRealm() {
        let data = FlightCheckingSaveData()
        data.name = dataChecking.name
        data.checkingDate = dataChecking.checkingDate

        try! realm.write {
            realm.add([data])
        }
        NotificationCenter.default.post(name: Notification.Name("UpdateChecking"), object: nil)
    }
    
    // MARK: - Public func
    
    func processButtonActions() {
        if dataChecking.name != "" && dataChecking.checkingDate != "" {
            viewController?.dismissViewController()
            saveDataToRealm()
        } else {
            viewController?.showAlert()
        }
    }
    
    func updateNameParameters(text: String) {
        dataChecking.name = text
    }
    
    func datePickerValueChanged(text: String) {
        dataChecking.checkingDate = text
    }
}
