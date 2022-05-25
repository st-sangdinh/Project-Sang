//
//  RecommendedTableViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 20/05/2022.
//

import Foundation

protocol RecommendedTableViewModelType {
    func getListMenu() -> Restaurant
    func getMenu(at indexPath: IndexPath) -> Menu
//    func viewModelForOrder(in indexPath: IndexPath) -> OrderViewModel
}

class RecommendedTableViewModel {
    var listRecommended: Restaurant
    init( listRecommended: Restaurant) {
        self.listRecommended =  listRecommended
    }
}

extension RecommendedTableViewModel: RecommendedTableViewModelType {

    func getListMenu() -> Restaurant {
        listRecommended
    }

    func getMenu(at indexPath: IndexPath) -> Menu {
        let menus = listRecommended.menus[indexPath.item]
        return menus
    }

//    func viewModelForOrder(in indexPath: IndexPath) -> OrderViewModel {
//        return OrderViewModel(listOrder: listRecommended.menus[indexPath.row], restaurant: listRecommended)
//    }
//    
}
