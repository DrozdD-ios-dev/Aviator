//
//  BaseTabBarItem.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import UIKit

final class BaseTabBarItem: UITabBarItem {
    convenience init(title: String, image: UIImage) {
        self.init(title: title, image: image, selectedImage: nil)
        self.imageInsets = UIEdgeInsets(top: 14, left: 6, bottom: 8, right: 6)
    }
}

