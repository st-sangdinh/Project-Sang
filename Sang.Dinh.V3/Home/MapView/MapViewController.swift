//
//  MapViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 29/04/2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var mapVIew2: MKMapView!
    
    var viewModel: MapViewModelType
    
    init(viewModel: MapViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configMapView()
//        configLocationServices()
        addAnnotation()
        locationManager.delegate = self
        mapVIew2.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        // Do any additional setup after loading the view.
    }
    
//
//    func configLocationServices() {
//        AppDelegate.shared.configLocationService()
//    }

    func configMapView() {
        let center = CLLocationCoordinate2D(latitude: viewModel.getLat(), longitude: viewModel.getLng())
        let span  = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        mapVIew2.region = MKCoordinateRegion(center: center, span: span)
        mapVIew2.showsUserLocation = true
    }
    
    
    func addAnnotation() {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: 16.071763, longitude: 108.223963)
            annotation.title = "Point 0001"
            annotation.subtitle = "subtitle 0001"
            mapVIew2.addAnnotation(annotation)
        }
    
    
//    func getDirections() {
//           let request = MKDirections.Request()
//           // Source
//           let sourcePlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 16.0472484, longitude: 108.1716005))
//           request.source = MKMapItem(placemark: sourcePlaceMark)
//           // Destination
//           let destPlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 73.3892, longitude: 173.1031))
//           request.destination = MKMapItem(placemark: destPlaceMark)
//           // Transport Types
//           request.transportType = [.automobile, .walking]
//           let directions = MKDirections(request: request)
//           directions.calculate { response, error in
//               guard let response = response else {
//                   print("Error: \(error?.localizedDescription ?? "No error specified").")
//                   return
//               }
//
//               let route = response.routes[0]
//               self.mapVIew2.addOverlay(route.polyline)
//           }
//       }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           print("location manager authorization status changed")
           
           switch status {
           case .authorizedAlways:
               print("user allow app to get location data when app is active or in background")
               
           case .authorizedWhenInUse:
               print("user allow app to get location data only when app is active")
               
           case .denied:
               print("user tap 'disallow' on the permission dialog, cant get location data")
               
           case .restricted:
               print("parental control setting disallow location data")
               
           case .notDetermined:
               print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
               
           default:
               print("default")
           }
       }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("latitude: \(location.coordinate.latitude), longitude: \(location.coordinate.longitude)")
            mapVIew2.setCenter(location.coordinate, animated: true)
          
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
}


extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         let renderer = MKPolylineRenderer(overlay: overlay)
         // Set the color for the line
         renderer.strokeColor = .red
         return renderer
     }
}
