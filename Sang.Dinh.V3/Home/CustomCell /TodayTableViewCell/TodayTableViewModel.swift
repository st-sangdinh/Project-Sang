//
//  TodataTableViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 04/05/2022.
//

import Foundation

protocol TodayTableViewModelType {
    func getListMenu() -> [ListMenu]
    
    func getMenu(at indexPath: IndexPath) -> ListMenu
    

}


class TodayTableViewModel {
    var listToday: [ListMenu] = []
    
    init(listToday: [ListMenu] = []) {
        self.listToday = listToday 
    }
}

extension TodayTableViewModel: TodayTableViewModelType {
    func getListMenu() -> [ListMenu] {
        listToday
    }
    
    func getMenu(at indexPath: IndexPath) -> ListMenu {
        listToday[indexPath.item]
    }
    
    
    
}
