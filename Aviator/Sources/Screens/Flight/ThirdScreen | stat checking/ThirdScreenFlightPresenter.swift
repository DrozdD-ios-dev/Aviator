//
//  ThirdScreenFlightPresenter.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import Foundation
import RealmSwift

// MARK: - Protocol

protocol ThirdScreenFlightInput {
    func makeReport()
    func viewDidLoad()
    var data: FlightCheckingSaveData { get }
    func updateNotes(text: String)
    func datePickerValueChanged(text: String)
    func updateStatusSystemsButton(status: Bool)
    func updateStatusElectronicsButton(status: Bool)
    func updateStatusIdentificationButton(status: Bool)
}

final class ThirdScreenFlightPresenter: ThirdScreenFlightInput {
    
    // MARK: - Properties
    
    weak var viewController: ThirdScreenFlightOutput?
    
    var data: FlightCheckingSaveData
    private let index: Int
    private let realm = try! Realm()
    private var itemsverificationModel: Results<VerificationCheckingSaveData>!
    private var itemsAircraftModel: Results<FlightCheckingSaveData>!
    
    private var verificationData = VerificationCheckingData(
        name: "",
        date: "",
        systemComponents: false,
        electronics: false,
        identification: false,
        notes: "")
    
    // MARK: - Init
    
    init(data: FlightCheckingSaveData, index: Int) {
        self.data = data
        self.index = index
        print(data.name)
    }
    
    // MARK: - Private func
    
    func deleteOneItem() {
        itemsAircraftModel = realm.objects(FlightCheckingSaveData.self)
        try! realm.write {
            realm.delete(itemsAircraftModel[index])
            NotificationCenter.default.post(name: Notification.Name("UpdateChecking"), object: nil)
            viewController?.dismissViewController()
        }
            }
    
    private func saveDataToRealm() {
        let data = VerificationCheckingSaveData()
        data.name = verificationData.name
        data.date = verificationData.date
        data.systemComponents = verificationData.systemComponents
        data.electronics = verificationData.electronics
        data.identification = verificationData.identification
        data.notes = verificationData.notes
        
        try! realm.write {
            realm.add([data])
        }
        NotificationCenter.default.post(name: Notification.Name("UpdateAnalyticsReports"), object: nil)
    }
    
    // MARK: - Public func
    
    func viewDidLoad() {
        verificationData.name = data.name
    }
    
    func makeReport() {
        if verificationData.date != "" && verificationData.notes != "" {
            saveDataToRealm()
            deleteOneItem()
        } else {
            viewController?.showAlert()
        }
    }
    
    func updateNotes(text: String) {
        verificationData.notes = text
    }
    
    func datePickerValueChanged(text: String) {
        if verificationData.date == "" {
            verificationData.date = text
            viewController?.updateTextfield(textField: text)
        }
    }
    
    func updateStatusSystemsButton(status: Bool) {
        verificationData.systemComponents = status
    }
    
    func updateStatusElectronicsButton(status: Bool) {
        verificationData.electronics = status
    }
    
    func updateStatusIdentificationButton(status: Bool) {
        verificationData.identification = status
    }
    
}
