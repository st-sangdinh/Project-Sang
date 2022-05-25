//
//  MapViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 16/05/2022.
//

import Foundation
protocol MapViewModelType {
    func getLat() -> Double
    func getLng() -> Double
}

class MapViewModel {
    let lat: String
    let lng: String

    init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
}

extension MapViewModel: MapViewModelType {
    func getLat() -> Double {
        Double(lat) ?? 0.0
    }

    func getLng() -> Double {
        Double(lng) ?? 0.0
    }
}
