//
//  CustomAppereance.swift
//  Aviator
//
//  Created by Дрозд Денис on 18.04.2024.
//

import UIKit

struct CustomAppearance {
    static func settingsAppearance() -> UITabBarAppearance {
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
        
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 3)
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return appearance
    }
}
