//
//  BookingTableViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 13/05/2022.
//

import Foundation


protocol BookingTableViewModelType {
    func getListMenu() -> [Restaurant]
    
    func getMenu(at indexPath: IndexPath) -> Restaurant
    

}


class BookingTableViewModel {
    var listToday: [Restaurant] = []
    
    init(listToday: [Restaurant] = []) {
        self.listToday = listToday
    }
}

extension BookingTableViewModel: BookingTableViewModelType {
    func getListMenu() -> [Restaurant] {
        listToday
    }
    
    func getMenu(at indexPath: IndexPath) -> Restaurant {
        listToday[indexPath.item]
    }
    
}
