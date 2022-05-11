//
//  OrderViewControllerModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 10/05/2022.
//

import Foundation

protocol OrderViewModelType {
    
    func getMenu() -> Menu
    
    func saveHistoryOrder()
}


class OrderViewModel {
    let listOrder: Menu
    var restaurantId: Int = 0
    var nameStore: String
    var address: String
    var img: String
    var number: Int = 0
    var note = ""
        
    init(listOrder: Menu, restaurantId: Int, nameStore: String, address: String, img: String){
        self.listOrder = listOrder
        self.restaurantId = restaurantId
        self.nameStore = nameStore
        self.address = address
        self.img = img
    }
}

extension OrderViewModel: OrderViewModelType {
    
    func saveHistoryOrder() {
        let item = ItemOrder(menuItem: listOrder , amout: number, notes: note)
        if let index = StoreOrderData.histories.firstIndex(where: { $0.restaurantId == restaurantId }) {
            StoreOrderData.histories[index].orderedItems.append(item)
        } else {
            let historyOrder = HistoryOrder(nameStore: nameStore, address: address, img: img, restaurantId: restaurantId, orderdDateTime: Date(), orderedItems: [item])
            StoreOrderData.histories.append(historyOrder)
        }
        
    }
    
    func getMenu() -> Menu {
        listOrder
    }
    
}

struct HistoryOrder {
    var nameStore: String
    var address: String
    var img: String
    var restaurantId: Int
    var orderdDateTime: Date
    var orderedItems: [ItemOrder] = []
}

struct ItemOrder {
    let menuItem: Menu
    let amout: Int
    let notes: String
}

