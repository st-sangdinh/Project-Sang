//
//  CartViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 12/05/2022.
//

import Foundation

protocol CartViewModelType {
    func saveHistoryOrder()
    func numberOfRowsInSection() -> Int
    func loadCart() -> Int
}

class CartViewModel {
    var priceDiscount: Int = 0
    var restaurantId: Int = 0
    var nameStore: String
    var address: String
    var img: String
    var number: Int = 0
    var note = ""

    init( restaurantId: Int, nameStore: String, address: String, img: String, priceDiscount: Int) {

        self.restaurantId = restaurantId
        self.nameStore = nameStore
        self.address = address
        self.img = img
        self.priceDiscount = priceDiscount

    }

    func saveHistoryOrder() {
        let idOrder = randomString(length: 5)
        CartDataStore.shared.getCart().forEach { cart in
            let item = ItemOrder(
                menuItem: cart.menuItem,
                restaurant: cart.restaurant,
                amout: cart.amout,
                priceDiscount: priceDiscount,
                notes: cart.notes)

            let storeDataOrder = StoreDataOrder.shared.getHistoryOrder()
            if let index = storeDataOrder.firstIndex(where: { $0.restaurantId == restaurantId && $0.id == idOrder }) {
//                StoreOrderData.histories[index].orderedItems.append(item)
                var storeOrder = storeDataOrder[index]
                storeOrder.orderedItems.append(item)
                StoreDataOrder.shared.replaceHistoryOrder(item: storeOrder, index: index)
//
            } else {
                let restaunrant = cart.restaurant
                let historyOrder = HistoryOrder(
                    id: idOrder,
                    nameStore: restaunrant.name,
                    address: restaunrant.address.address,
                    img: restaunrant.photos.first,
                    restaurantId: restaunrant.id,
                    orderdDateTime: Date(),
                    orderedItems: [item])
//                StoreOrderData.histories.append(historyOrder)
                StoreDataOrder.shared.appendHistoryOrder(item: historyOrder)
            }

        }
    }
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }
}

extension CartViewModel: CartViewModelType {
    func numberOfRowsInSection() -> Int {
         CartDataStore.shared.getCart().count
    }

    func loadCart() -> Int {
        priceDiscount = 0
//        totalAmout = 0
        CartDataStore.shared.getCart().forEach { item in
            let price = item.menuItem.price
            var discount = item.menuItem.discount
            let amout = item.amout
//            totalAmout += item.amout
//            totalPrice += item.amout * item.menuItem.price
            discount = Int(Float(price) * (Float(Float(100 - discount) / 100)))
            priceDiscount += discount * amout
        }
        return  priceDiscount
    }
}
