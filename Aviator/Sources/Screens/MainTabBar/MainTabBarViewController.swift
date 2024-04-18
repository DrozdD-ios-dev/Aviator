//
//  MainTabBarViewController.swift
//  Aviator
//
//  Created by Дрозд Денис on 17.04.2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    // MARK: - Properties
    
    let maintenanceViewController =  MaintenanceAssembly.build()
    let monitoringViewController = MonitoringAssembly.build()
    let flightViewController = FlightAssembly.build()
    let analyticsViewController = AnalyticsAssembly.build()
    let settingsViewController = SettingsAssembly.build()
    
    // MARK: - LifeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBarItems()
        setupAppearance()
        createCustomLine()
    }
    
    private func createTabBarItems() {
        let itemOne: BaseTabBarItem = {
            let item = BaseTabBarItem(title: "Maintenance", image: UIImage(named: "1") ?? UIImage._1)
            return item
        }()
        
        let itemTwo: BaseTabBarItem = {
            let item = BaseTabBarItem(title: "Monitoring", image: UIImage(named: "2") ?? UIImage._1)
            return item
        }()
        
        let itemThree: BaseTabBarItem = {
            let item = BaseTabBarItem(title: "Flight", image: UIImage(named: "3") ?? UIImage._1)
            return item
        }()
        
        let itemFour: BaseTabBarItem = {
            let item = BaseTabBarItem(title: "Analytics", image: UIImage(named: "4") ?? UIImage._1)
            return item
        }()
        
        let itemFive: BaseTabBarItem = {
            let item = BaseTabBarItem(title: "Settings", image: UIImage(named: "5") ?? UIImage._1)
            return item
        }()
        
        maintenanceViewController.tabBarItem = itemOne
        monitoringViewController.tabBarItem = itemTwo
        flightViewController.tabBarItem = itemThree
        analyticsViewController.tabBarItem = itemFour
        settingsViewController.tabBarItem = itemFive
        
        viewControllers = [maintenanceViewController, monitoringViewController, flightViewController, analyticsViewController, settingsViewController]
    }
    
    private func setupAppearance() {
        let appearance = CustomAppearance.settingsAppearance()
        tabBar.standardAppearance = appearance
        tabBar.backgroundColor = UIColor(named: "Gray43")
    }
    
    private func createCustomLine() {
        let topLine = CALayer()
        topLine.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2.5)
        topLine.backgroundColor = UIColor(named: "Red239")?.cgColor
        tabBar.layer.addSublayer(topLine)
    }
    
}
