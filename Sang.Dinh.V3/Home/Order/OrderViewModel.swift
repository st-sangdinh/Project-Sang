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

        if let index = CartData.carts.firstIndex(where: { $0.menuItem.id == item.menuItem.id }) {
            CartData.carts[index] = item
        } else {
            CartData.carts.append(item)
        }
    }
    func getMenu() -> Menu {
        listOrder
    }
    
}

struct HistoryOrder {
    var nameStore: String
    var address: String
    var img: String?
    var restaurantId: Int
    var orderdDateTime: Date
    var orderedItems: [ItemOrder] = []
}

struct ItemOrder {
    let menuItem: Menu
    let restaurant: Restaurant
    var amout: Int
    let notes: String
}
