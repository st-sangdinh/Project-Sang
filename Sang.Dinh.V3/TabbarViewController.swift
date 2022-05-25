//
//  TabbarViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 27/04/2022.
//

import Foundation
import UIKit

final class TabbarViewController: UITabBarController {
    let homeVC = HomeViewController()
    let bookingVC = BookingViewController()
    let accountVC = AccountViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarViewController()
        custom()
    }

    private func tabBarViewController () {
        let homeVN = UINavigationController(rootViewController: homeVC)
        homeVN.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Home"),
            selectedImage: UIImage(named: "Home"))

        let bookingHistoryVN = UINavigationController(rootViewController: bookingVC)
        bookingHistoryVN.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Booking"),
            selectedImage: UIImage(named: "Booking"))

        let accountVN = UINavigationController(rootViewController: accountVC)
        accountVN.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Account"),
            selectedImage: UIImage(named: "Account"))

        viewControllers = [homeVN, bookingHistoryVN, accountVN]
    }

    private func custom() {
        tabBar.tintColor = UIColor(red: 0.196, green: 0.718, blue: 0.408, alpha: 1)
        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.backgroundColor = .white
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -5)
        tabBar.layer.shadowRadius = 14
        tabBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        tabBar.layer.shadowOpacity = 1
    }
}
