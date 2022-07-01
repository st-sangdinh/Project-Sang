//
//  Menu.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 04/05/2022.
//

import Foundation

struct Restaurant: Codable {
    var id: Int
    var name: String
    var address: Address
    var photos: [String]
    var menus: [Menu]
}

struct Address: Codable {
    var lat: String = ""
    var lng: String = ""
    var address: String = ""
}

struct Menu: Codable {
    var id: Int = 0
    var type: Int = 0
    var name: String = ""
    var description: String = ""
    var price: Int = 0
    var imageUrl: String = ""
    var discount: Int = 0
}

struct RestaurantResponse: Codable {
    var data: [Restaurant]
}

struct ListBanners: Codable {
    var id: Int = 0
    var imageUrl: String = ""
}

struct ListBannersResponse: Codable {
    var data: [ListBanners]
}
