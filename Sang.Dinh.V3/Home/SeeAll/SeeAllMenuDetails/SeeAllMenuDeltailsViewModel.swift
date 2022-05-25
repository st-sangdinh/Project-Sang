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
    func viewModelForOrder(in indexPath: IndexPath, priceDiscount: Int) -> OrderViewModel
    func viewModelForCart(price: Int) -> CartViewModel
}

class SeeAllMenuDeltailsViewModel {
    var listAllRecommended: Restaurant

    init( listAllRecommended: Restaurant) {
        self.listAllRecommended =  listAllRecommended
    }
}

extension SeeAllMenuDeltailsViewModel: SeeAllMenuDeltailsViewModelType {
    func getRecommende() -> Restaurant {
        listAllRecommended
    }

    func getMenu(at indexPath: IndexPath) -> Menu {
        let menus = listAllRecommended.menus[indexPath.item]
        return menus
    }

    func viewModelForOrder(in indexPath: IndexPath, priceDiscount: Int) -> OrderViewModel {
        return OrderViewModel(
            listOrder: listAllRecommended.menus[indexPath.row],
            restaurant: listAllRecommended,
            priceDiscount: priceDiscount)
    }

    func viewModelForCart(price: Int) -> CartViewModel {
        return CartViewModel(
            restaurantId: listAllRecommended.id,
            nameStore: listAllRecommended.name,
            address: listAllRecommended.address.address,
            img: listAllRecommended.photos.first ?? "",
            price: price)
    }
}
