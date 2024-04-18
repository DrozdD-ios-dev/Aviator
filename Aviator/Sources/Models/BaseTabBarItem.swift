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
        self.imageInsets = UIEdgeInsets(top: 16, left: 10, bottom: 10, right: 10)
    }
}

