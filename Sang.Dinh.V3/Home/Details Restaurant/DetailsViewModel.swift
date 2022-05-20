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
    
    func viewModelForCart(price: Int) -> CartViewModel
    
    func viewModelForMap() -> MapViewModel
    
    func cartOrder() -> [HistoryOrder]
    
}


class DetailsViewModel {
    var listDetails: Restaurant
    
    init(listDetails: Restaurant) {
        self.listDetails = listDetails
    }
}


extension DetailsViewModel: DetailsViewModelType {
    func viewModelForMap() -> MapViewModel {
        return MapViewModel(lat: listDetails.address.lat, lng: listDetails.address.lng)
    }
    
    func viewModelForCart(price: Int) -> CartViewModel {
        return CartViewModel( restaurantId: listDetails.id, nameStore: listDetails.name, address: listDetails.address.address, img: listDetails.photos.first ?? "", price: price)
    }
    
    func cartOrder() ->  [HistoryOrder]{
        return StoreDataOrder.shared.getHistoryOrder()
    }
    
    func viewModelForOrder(in indexPath: IndexPath) -> OrderViewModel {
        return OrderViewModel(listOrder: listDetails.menus[indexPath.row], restaurant: listDetails)
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



