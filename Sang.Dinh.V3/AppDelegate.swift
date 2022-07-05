//
//  AppDelegate.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 27/04/2022.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeVC = OnboardingViewController()
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()
        return true
    }
}
