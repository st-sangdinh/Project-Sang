//
//  DetailsViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 09/05/2022.
//

import Foundation

protocol DetailsViewModelType {
    
    func getListMenu() -> ListMenu

    
    func getMenu(at indexPath: IndexPath) -> Menu
    
    func viewModelForDetails(in indexPath: IndexPath) -> DetailsTableViewModel
    
    func viewModelForOrder(in indexPath: IndexPath) -> OrderViewModel
    
}


class DetailsViewModel {
    var listDetails: ListMenu
    
    init(listDetails: ListMenu) {
        self.listDetails = listDetails
    }
}


extension DetailsViewModel: DetailsViewModelType {
    func viewModelForOrder(in indexPath: IndexPath) -> OrderViewModel {
        return OrderViewModel(listOrder: listDetails.menu[indexPath.row], restaurantId: listDetails.id, nameStore: listDetails.name, address: listDetails.address.address, img: listDetails.photos.first ?? "")
    }
    
    func viewModelForDetails(in indexPath: IndexPath) -> DetailsTableViewModel {
        return DetailsTableViewModel(listDetails: listDetails)
    }
    
    
    func getListMenu() -> ListMenu {
        listDetails
    }
    
    func getMenu(at indexPath: IndexPath) -> Menu {
        let menus = listDetails.menu[indexPath.item]
        return menus
    }
    
}
