//
//  AppDelegate.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 27/04/2022.
//

import UIKit
import CoreLocation
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true   // kich hoat IQKeyboardManager
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false // placeholder trong textField's
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true  // tap ben ngoai ban phim se thoat khoi textField's
//        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "OK"  // text button Done
        IQKeyboardManager.shared.enableDebugging = true  //  enableDebugging = true
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeVC = OnboardingViewController()
        let navi = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
        return true
    }
}
