//
//  MapViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 29/04/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    

    @IBOutlet weak var mapVIew2: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configMapView()
        configLocationServices()
        // Do any additional setup after loading the view.
    }
    
    let center = CLLocationCoordinate2D(latitude: 16.0472484, longitude: 108.1716005)
    let span  = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    

    func configLocationServices() {
        AppDelegate.shared.configLocationService()
    }

    func configMapView() {
        let mapView = MKMapView(frame: UIScreen.main.bounds)
//        mapView.region = MKCoordinateRegion(center: center, span: span)
//        mapView.camera = MKMapCamera(lookingAtCenter: center, fromEyeCoordinate: eyeCoorinate, eyeAltitude: 200)
        mapVIew2.showsUserLocation = true
    }
    
    
    
//    func addAnnotation() {
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 16.044, longitude: 108.172)
//        annotation.title = "Point Annotation"
//        annotation.subtitle = "Point nannotation infomation"
//        mapView.addAnnotation(annotation)
//    }

}
