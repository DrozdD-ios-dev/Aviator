//
//  FirstScreenAircraftMaintenancePresenter.swift
//  Aviator
//
//  Created by Дрозд Денис on 20.04.2024.
//

import Foundation
import RealmSwift

// MARK: - Protocol

protocol FirstScreenMaintenanceAircraftInput {
    func viewDidLoad()
    func deleteOneItem()
    var data: AircraftSavedData { get }
}

final class FirstScreenAircraftMaintenancePresenter: FirstScreenMaintenanceAircraftInput {
    
    // MARK: - Properties
    
    weak var viewController: FirstScreenAircraftMaintenanceOutput?
    
    var data: AircraftSavedData
    private let index: Int
    private let realm = try! Realm()
    private var itemsAircraftModel: Results<AircraftSavedData>!

    // MARK: - Init
    
    init(data: AircraftSavedData, index: Int) {
        self.data = data
        self.index = index 
    }

    // MARK: - Public func
    
    func viewDidLoad() {
        viewController?.sendInspectionData(data: data)
    }
    
    func deleteOneItem() {
        itemsAircraftModel = realm.objects(AircraftSavedData.self)
        try! realm.write {
            realm.delete(itemsAircraftModel[index])
            NotificationCenter.default.post(name: Notification.Name("Update"), object: nil)
            viewController?.dismissViewController()
        }
    }
}
