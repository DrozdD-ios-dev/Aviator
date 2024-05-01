//
//  AnalyticsExtraScreenPresenter.swift
//  Aviator
//
//  Created by Дрозд Денис on 25.04.2024.
//

import Foundation
import RealmSwift

// MARK: - Protocol

protocol AnalyticsExtraScreenInput {
    func viewDidLoad()
    func deleteOneItem()
    var data: VerificationCheckingSaveData { get }
}

final class AnalyticsExtraScreenPresenter: AnalyticsExtraScreenInput {
    
    // MARK: - Properties
    
    weak var viewController: AnalyticsExtraScreenOutput?
    
    var data: VerificationCheckingSaveData
    private let index: Int
    private let realm = try! Realm()
    private var itemsVerificationModel: Results<VerificationCheckingSaveData>!
    
    // MARK: - Init
    
    init(data: VerificationCheckingSaveData, index: Int) {
        self.data = data
        self.index = index
    }
    
    // MARK: - Public func
    
    func viewDidLoad() {
        viewController?.sendParametersData(data: data)
    }
    
    func deleteOneItem() {
                itemsVerificationModel = realm.objects(VerificationCheckingSaveData.self)
                try! realm.write {
                    realm.delete(itemsVerificationModel[index])
                    NotificationCenter.default.post(name: Notification.Name("UpdateAnalyticsReports"), object: nil)
                    viewController?.dismissViewController()
                }
            }
    }

