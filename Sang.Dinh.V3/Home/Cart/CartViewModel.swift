//
//  CartViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 12/05/2022.
//

import Foundation

protocol CartViewModelType {
    func saveHistoryOrder()
    
}


class CartViewModel {

    var restaurantId: Int = 0
    var nameStore: String
    var address: String
    var img: String
    var number: Int = 0
    var note = ""
    var price: Int = 0
        
    init( restaurantId: Int, nameStore: String, address: String, img: String, price: Int){

        self.restaurantId = restaurantId
        self.nameStore = nameStore
        self.address = address
        self.img = img
        self.price = price

    }
    
    func saveHistoryOrder() {
        let idOrder = randomString(length: 5)
        CartDataStore.shared.getCart().forEach{cart in
            let item = ItemOrder(menuItem: cart.menuItem, restaurant: cart.restaurant, amout: cart.amout, notes: cart.notes)
            var storeDataOrder = StoreDataOrder.shared.getHistoryOrder()
            if let index = storeDataOrder.firstIndex(where: { $0.restaurantId == restaurantId && $0.id == idOrder }) {
//                StoreOrderData.histories[index].orderedItems.append(item)
                storeDataOrder[index].orderedItems.append(item)
                CartDataStore.shared.insertItemOrder(item: item, index: index)
                
            } else {
                let historyOrder = HistoryOrder(id: idOrder, nameStore: cart.restaurant.name, address: cart.restaurant.address.address, img: cart.restaurant.photos.first, restaurantId: cart.restaurant.id, orderdDateTime: Date(), orderedItems: [item])
//                StoreOrderData.histories.append(historyOrder)
                StoreDataOrder.shared.appendHistoryOrder(item: historyOrder)
                
            }

        }
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
