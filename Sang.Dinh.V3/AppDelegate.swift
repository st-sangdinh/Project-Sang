//
//  AppDelegate.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 27/04/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeVC = HomeViewController()
        let navi = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
        return true
    }
}

