//
//  AppDelegate.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 27/04/2022.
//

import UIKit
import CoreLocation

class StoreOrderData {
    static var histories: [HistoryOrder] = []
}

class CartData {
    static var carts: [ItemOrder] = []
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    static let shared: AppDelegate = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot cast to AppDelegate.")
        }
        return delegate
    }()
    
    
    var window: UIWindow?
    
    lazy var locationManager = CLLocationManager()
    let mapsViewController = MapViewController()
    
    func enableLocationService(){
        CLLocationManager.locationServicesEnabled()
    }
    func startStandardLocationService() {
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 500
        locationManager.startUpdatingLocation()
    }
    func stopStandarLocationService() {
        locationManager.startUpdatingLocation()
    }
    
    func startSignificanChangeLocationService() {
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func stopSignificanChangeLocationService() {
        locationManager.stopMonitoringSignificantLocationChanges()
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeVC = TabbarViewController()
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()
        return true
    }
    
    func configLocationService() {
        locationManager.delegate = self
        let status = locationManager.authorizationStatus
        switch status {
            case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            print("USER using app")
            break
        case .denied:
            let title = "Request location service"
            let message = "Please go to Setting > Privacy > Location service to turn on location service for \"Map demo\""
            showAlert(title: title, message: message)
        case .restricted:
            break
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(action)
        window?.rootViewController?.present(alertVC, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {return}
        print("timestampe \(lastLocation.timestamp)")
        print("lat \(lastLocation.coordinate.latitude)")
        print("lng \(lastLocation.coordinate.longitude)")
    }

}

