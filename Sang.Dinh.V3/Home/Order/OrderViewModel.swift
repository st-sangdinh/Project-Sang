//
//  OrderViewControllerModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 10/05/2022.
//

import Foundation

protocol OrderViewModelType {
    
    func getMenu() -> Menu
    

}


class OrderViewModel {
    let listOrder: Menu
//    var restaurantId: Int = 0
//    var nameStore: String
//    var address: String
//    var img: String
    let restaurent: Restaurant
    var number: Int = 0
    var note = ""
        
    init(listOrder: Menu, restaurant: Restaurant){
        self.listOrder = listOrder
        self.restaurent = restaurant

    }
}

extension OrderViewModel: OrderViewModelType {

    func saveCartData() {
        let item = ItemOrder(menuItem: listOrder, restaurant: restaurent, amout: number, notes: note)

        let carts = CartDataStore.shared.getCart()
        if let index = carts.firstIndex(where: { $0.menuItem.id == item.menuItem.id }) {
//            CartData.carts[index] = item
                CartDataStore.shared.replaceItemOrder(item: item, index: index)
        } else {
            CartDataStore.shared.appendCart(item: item)
        }
    } 
    func getMenu() -> Menu {
        listOrder
    }
    
}

struct HistoryOrder: Codable {
    var id: String
    var nameStore: String
    var address: String
    var img: String?
    var restaurantId: Int
    var orderdDateTime: Date?
    var orderedItems: [ItemOrder] = []
}

struct ItemOrder: Codable {
    var menuItem: Menu
    let restaurant: Restaurant
    var amout: Int
    let notes: String
}
