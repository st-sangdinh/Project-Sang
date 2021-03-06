//
//  DetailsViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 09/05/2022.
//

import Foundation

protocol DetailsViewModelType {

    func getListMenu() -> Restaurant

    func getMenu(at indexPath: IndexPath) -> Menu

    func viewModelForDetails(in indexPath: IndexPath) -> DetailsTableViewModel

    func viewModelForOrder(in indexPath: IndexPath) -> OrderViewModel

    func viewModelForCart() -> CartViewModel

    func viewModelForMap() -> MapViewModel

    func viewModelForRecommended() -> RecommendedTableViewModel

    func viewForAllRecommended() -> SeeAllMenuDeltailsViewModel

    func cartOrder() -> [HistoryOrder]

    func loadCart() -> (Int, Int)

}

class DetailsViewModel {
    var priceDiscount: Int = 0
    var totalAmout: Int = 0
    var listDetails: Restaurant

    init(listDetails: Restaurant) {
        self.listDetails = listDetails
    }
}

extension DetailsViewModel: DetailsViewModelType {
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
        return (totalAmout, priceDiscount)
    }

    func viewForAllRecommended() -> SeeAllMenuDeltailsViewModel {
        return SeeAllMenuDeltailsViewModel(listAllRecommended: listDetails)
    }

    func viewModelForRecommended() -> RecommendedTableViewModel {
        return RecommendedTableViewModel(listRecommended: listDetails)
    }

    func viewModelForMap() -> MapViewModel {
        return MapViewModel(lat: listDetails.address.lat, lng: listDetails.address.lng)
    }

    func viewModelForCart() -> CartViewModel {
        return CartViewModel(
            restaurantId: listDetails.id,
            nameStore: listDetails.name,
            address: listDetails.address.address,
            img: listDetails.photos.first ?? "",
            priceDiscount: priceDiscount)
    }

    func cartOrder() -> [HistoryOrder] {
        return StoreDataOrder.shared.getHistoryOrder()
    }

    func viewModelForOrder(in indexPath: IndexPath) -> OrderViewModel {
        return OrderViewModel(
            listOrder: listDetails.menus[indexPath.row],
            restaurant: listDetails,
            priceDiscount: priceDiscount)
    }

    func viewModelForDetails(in indexPath: IndexPath) -> DetailsTableViewModel {
        return DetailsTableViewModel(listDetails: listDetails)
    }

    func getListMenu() -> Restaurant {
        listDetails
    }

    func getMenu(at indexPath: IndexPath) -> Menu {
        let menus = listDetails.menus[indexPath.item]
        return menus
    }
}
