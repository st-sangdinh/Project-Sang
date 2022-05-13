//
//  SeeALLViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 10/05/2022.
//

import Foundation

protocol SeeALLViewModelType {
    func getListMenu() -> [Restaurant]
    
    func getMenu(at indexPath: IndexPath) -> Restaurant
    
    func viewMdelForDetailsView(in indexPath: IndexPath) -> DetailsViewModel
}


class SeeALLViewModel {
    var listToday: [Restaurant] = []
    
    init(listToday: [Restaurant] = []) {
        self.listToday = listToday
    }
}

extension SeeALLViewModel: SeeALLViewModelType {
    func viewMdelForDetailsView(in indexPath: IndexPath) -> DetailsViewModel {
        return DetailsViewModel(listDetails: listToday[indexPath.item])
    }
    
    func getListMenu() -> [Restaurant] {
        listToday
    }
    
    func getMenu(at indexPath: IndexPath) -> Restaurant {
        listToday[indexPath.item]
    }
    
    
    
}
