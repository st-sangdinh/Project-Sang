//
//  Menu.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 04/05/2022.
//

import Foundation


struct ListMenu {
    var id: Int = 0
    var name: String = ""
    var address: Address = Address()
    var photos: [String] = []
    var menu: [Menu] = []
}

struct Address {
    var lat: Double = 0
    var lng: Double = 0
    var address: String = ""
}

struct Menu {
    var id: Int = 0
    var type: Int = 0
    var name: String = ""
    var description: String = ""
    var price: Int = 0
    var imageUrl: String = ""
    var number: Int = 0
    var discount: Int = 0
}
