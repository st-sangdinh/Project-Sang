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
}

class TodayTableViewModel {
    var listToday: [Restaurant] = []

    init(listToday: [Restaurant] = []) {
        self.listToday = listToday
    }
}

extension TodayTableViewModel: TodayTableViewModelType {
    func getListMenu() -> [Restaurant] {
        listToday
    }

    func getMenu(at indexPath: IndexPath) -> Restaurant {
        listToday[indexPath.section]
    }
}
