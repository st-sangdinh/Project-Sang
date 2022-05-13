//
//  DetailsViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 09/05/2022.
//

import Foundation

protocol DetailsViewModelType {
    
    func getListMenu() -> Restaurant

    func price() -> Int
    
    func quantity() -> Int
    
    func getMenu(at indexPath: IndexPath) -> Menu
    
    func viewModelForDetails(in indexPath: IndexPath) -> DetailsTableViewModel
    
    func viewModelForOrder(in indexPath: IndexPath) -> OrderViewModel
    
    func viewModelForCart() -> CartViewModel
    
    func cartOrder() -> [HistoryOrder]
    
}


class DetailsViewModel {
    var listDetails: Restaurant
    var totalPrice: Int = 0
    var totalAmout: Int = 0
    
    init(listDetails: Restaurant) {
        self.listDetails = listDetails
    }
}


extension DetailsViewModel: DetailsViewModelType {
    func quantity() -> Int {
        totalAmout
    }
    
    func price() -> Int{
        CartData.carts.forEach{ item in
            totalAmout += item.amout
            totalPrice += item.amout * item.menuItem.price
        }
        return totalPrice
    }
    
    func viewModelForCart() -> CartViewModel {
        return CartViewModel( restaurantId: listDetails.id, nameStore: listDetails.name, address: listDetails.address.address, img: listDetails.photos.first ?? "", price: totalPrice)
    }
    
    func cartOrder() ->  [HistoryOrder]{
        return StoreOrderData.histories
    }
    
    func viewModelForOrder(in indexPath: IndexPath) -> OrderViewModel {
        return OrderViewModel(listOrder: listDetails.menu[indexPath.row], restaurant: listDetails)
    }
    
    func viewModelForDetails(in indexPath: IndexPath) -> DetailsTableViewModel {
        return DetailsTableViewModel(listDetails: listDetails)
    }
    
    
    func getListMenu() -> Restaurant {
        listDetails
    }
    
    func getMenu(at indexPath: IndexPath) -> Menu {
        let menus = listDetails.menu[indexPath.item]
        return menus
    }
    
}



