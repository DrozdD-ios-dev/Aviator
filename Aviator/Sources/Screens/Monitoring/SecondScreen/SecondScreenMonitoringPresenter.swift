//
//  SecondScreenMonitoringPresenter.swift
//  Aviator
//
//  Created by Дрозд Денис on 24.04.2024.
//

import Foundation
import RealmSwift

// MARK: - Protocol

protocol SecondScreenMonitoringInput {
    func viewDidLoad()
    func deleteOneItem()
    var data: MonitoringParametersSavedData { get }
}

final class SecondScreenMonitoringPresenter: SecondScreenMonitoringInput {
    
    // MARK: - Properties
    
    weak var viewController: SecondScreenMonitoringOutput?
    
    var data: MonitoringParametersSavedData
    private let index: Int
    private let realm = try! Realm()
    private var itemsAircraftModel: Results<MonitoringParametersSavedData>!
    
    // MARK: - Init
    
    init(data: MonitoringParametersSavedData, index: Int) {
        self.data = data
        self.index = index
    }
    
    // MARK: - Public func
    
    func viewDidLoad() {
        viewController?.sendParametersData(data: data)
    }
    
    func deleteOneItem() {
                itemsAircraftModel = realm.objects(MonitoringParametersSavedData.self)
                try! realm.write {
                    realm.delete(itemsAircraftModel[index])
                    NotificationCenter.default.post(name: Notification.Name("UpdateParameters"), object: nil)
                    viewController?.dismissViewController()
                }
            }
    }
