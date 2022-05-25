//
//  SeeAllTodayViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 23/05/2022.
//

import Foundation

protocol SeeAllTodayViewModelType {
    func getListMenu() -> [Restaurant]
    func getMenu(at indexPath: IndexPath) -> Restaurant
    func viewMdelForDetailsView(in indexPath: IndexPath) -> DetailsViewModel
}

class SeeAllTodayViewModel {
    var listMenu: [Restaurant] = []
    init(listMenu: [Restaurant] = []) {
        self.listMenu = listMenu
    }
}

extension SeeAllTodayViewModel: SeeAllTodayViewModelType {
    func viewMdelForDetailsView(in indexPath: IndexPath) -> DetailsViewModel {
        return DetailsViewModel(listDetails: listMenu[indexPath.section])
    }

    func getListMenu() -> [Restaurant] {
        listMenu
    }

    func getMenu(at indexPath: IndexPath) -> Restaurant {
        listMenu[indexPath.section]
    }

}
