//
//  FlightPresenter.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import Foundation
import RealmSwift

// MARK: - Protocol

protocol FlightInput {
    var flightDataBase: [FlightCheckingSaveData] { get }
    func setupBackgroundImage()
    func updateData()
}

final class FlightPresenter: FlightInput {
    
    // MARK: - Properties
    
    weak var viewController: FlightOutput?
    
    private let realm = try! Realm()
    private var itemsFlightModel: Results<FlightCheckingSaveData>!
    var flightDataBase: [FlightCheckingSaveData] = []
    
    // MARK: - Public function
    
    func updateData() {
        itemsFlightModel = realm.objects(FlightCheckingSaveData.self)
        flightDataBase = Array(itemsFlightModel)
    }
    
    func setupBackgroundImage() {
        if flightDataBase.count == 0 {
            viewController?.setupBackgroundImage(parameter: false)
        } else {
            viewController?.setupBackgroundImage(parameter: true)
        }
    }
}
