//
//  MonitoringPresenter.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import Foundation
import RealmSwift

// MARK: - Protocol

protocol MonitoringInput {
    var monitoringDataBase: [MonitoringParametersSavedData] { get }
    func setupBackgroundImage()
    func updateData()
}

final class MonitoringPresenter: MonitoringInput {
    
    // MARK: - Properties
    
    weak var viewController: MonitoringOutput?
    
    private let realm = try! Realm()
    private var itemsParametersModel: Results<MonitoringParametersSavedData>!
    var monitoringDataBase: [MonitoringParametersSavedData] = []
    
    // MARK: - Public function
    
    func updateData() {
        itemsParametersModel = realm.objects(MonitoringParametersSavedData.self)
        monitoringDataBase = Array(itemsParametersModel)
    }
    
    func setupBackgroundImage() {
        if monitoringDataBase.count == 0 {
            viewController?.setupBackgroundImage(parameter: false)
        } else {
            viewController?.setupBackgroundImage(parameter: true)
        }
    }
}
