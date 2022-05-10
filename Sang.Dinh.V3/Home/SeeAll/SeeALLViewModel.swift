//
//  SeeALLViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 10/05/2022.
//

import Foundation

protocol SeeALLViewModelType {
    func getListMenu() -> [ListMenu]
    
    func getMenu(at indexPath: IndexPath) -> ListMenu
    
    func viewMdelForDetailsView(in indexPath: IndexPath) -> DetailsViewModel
}


class SeeALLViewModel {
    var listToday: [ListMenu] = []
    
    init(listToday: [ListMenu] = []) {
        self.listToday = listToday
    }
}

extension SeeALLViewModel: SeeALLViewModelType {
    func viewMdelForDetailsView(in indexPath: IndexPath) -> DetailsViewModel {
        return DetailsViewModel(listDetails: listToday[indexPath.item])
    }
    
    func getListMenu() -> [ListMenu] {
        listToday
    }
    
    func getMenu(at indexPath: IndexPath) -> ListMenu {
        listToday[indexPath.item]
    }
    
    
    
}
