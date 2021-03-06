//
//  SeeAllMenuDeltailsViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 20/05/2022.
//

import Foundation

protocol SeeAllMenuDeltailsViewModelType {
    func getRecommende() -> Restaurant
    func getMenu(at indexPath: IndexPath) -> Menu
    func numberOfItemsInSection() -> Int
    func viewModelForOrder(in indexPath: IndexPath) -> OrderViewModel
    func viewModelForCart() -> CartViewModel
    func loadCart() -> (Int, Int)
}

class SeeAllMenuDeltailsViewModel {
    var listAllRecommended: Restaurant
    var priceDiscount: Int = 0
    var totalAmout: Int = 0

    init( listAllRecommended: Restaurant ) {
        self.listAllRecommended =  listAllRecommended
    }
}

extension SeeAllMenuDeltailsViewModel: SeeAllMenuDeltailsViewModelType {
    func numberOfItemsInSection() -> Int {
        listAllRecommended.menus.count
    }

    func loadCart() -> (Int, Int) {
        priceDiscount = 0
        totalAmout = 0
        CartDataStore.shared.getCart().forEach { item in
            let price = item.menuItem.price
            var discount = item.menuItem.discount
            let amout = item.amout
            totalAmout += item.amout
//            totalPrice += item.amout * item.menuItem.price
            discount = Int(Float(price) * (Float(Float(100 - discount) / 100)))
            priceDiscount += discount * amout
        }
        return (priceDiscount, totalAmout)
    }

    func getRecommende() -> Restaurant {
        listAllRecommended
    }

    func getMenu(at indexPath: IndexPath) -> Menu {
        let menus = listAllRecommended.menus[indexPath.item]
        return menus
    }

    func viewModelForOrder(in indexPath: IndexPath) -> OrderViewModel {
        return OrderViewModel(
            listOrder: listAllRecommended.menus[indexPath.row],
            restaurant: listAllRecommended,
            priceDiscount: priceDiscount)
    }

    func viewModelForCart() -> CartViewModel {
        return CartViewModel(
            restaurantId: listAllRecommended.id,
            nameStore: listAllRecommended.name,
            address: listAllRecommended.address.address,
            img: listAllRecommended.photos.first ?? "",
            priceDiscount: priceDiscount)
    }
}
