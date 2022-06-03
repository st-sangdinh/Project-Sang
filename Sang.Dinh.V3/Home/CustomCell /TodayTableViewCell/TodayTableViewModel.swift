//
//  TodataTableViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 04/05/2022.
//

import Foundation

protocol TodayTableViewModelType {
    func getListMenu() -> [Restaurant]
    func getMenu(at indexPath: IndexPath) -> Restaurant
    func numberOfItemsInSection() -> Int
}

class TodayTableViewModel {
    var listToday: [Restaurant] = []

    init(listToday: [Restaurant] = []) {
        self.listToday = listToday
    }
}

extension TodayTableViewModel: TodayTableViewModelType {
    func numberOfItemsInSection() -> Int {
        if listToday.first?.menus.count ?? 0 > 4 {
            return 4
        } else {
            return listToday.first?.menus.count ?? 0
        }
    }

    func getListMenu() -> [Restaurant] {
        listToday
    }

    func getMenu(at indexPath: IndexPath) -> Restaurant {
        listToday[indexPath.section]
    }
}
