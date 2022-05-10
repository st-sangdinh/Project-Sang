//
//  Menu.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 04/05/2022.
//

import Foundation


struct ListMenu {
    var id: Int
    var name: String
    var address: Address
    var photos: [String]
    var menu: [Menu]
}

struct Address {
    var lat: Double
    var lng: Double
    var address: String
}

struct Menu {
    var id: Int
    var type: Int
    var name: String
    var description: String
    var price: Int
    var imageUrl: String
    var number: Int
    var discount: Int
}
