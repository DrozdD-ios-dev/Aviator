//
//  AnalyticsPresenter.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import Foundation
import RealmSwift

// MARK: - Protocol

protocol AnalyticsInput {
    var verificationDataBase: [VerificationCheckingSaveData] { get }
    func setupBackgroundImage()
    func updateData()
}

final class AnalyticsPresenter: AnalyticsInput {
    
    // MARK: - Properties
    
    weak var viewController: AnalyticsOutput?
    
    private let realm = try! Realm()
    private var itemsVerificationModel: Results<VerificationCheckingSaveData>!
    var verificationDataBase: [VerificationCheckingSaveData] = []
    
    // MARK: - Public function
    
    func updateData() {
        itemsVerificationModel = realm.objects(VerificationCheckingSaveData.self)
        verificationDataBase = Array(itemsVerificationModel)
    }
    
    func setupBackgroundImage() {
        if verificationDataBase.count == 0 {
            viewController?.setupBackgroundImage(parameter: false)
        } else {
            viewController?.setupBackgroundImage(parameter: true)
        }
    }
}
