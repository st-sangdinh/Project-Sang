//
//  DetailsTableViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 09/05/2022.
//

import Foundation

protocol DetailsTableViewModelType {
    func getListMenu() -> Restaurant
}

class DetailsTableViewModel {
    var listDetails: Restaurant

    init(listDetails: Restaurant) {
        self.listDetails = listDetails
    }
}

extension DetailsTableViewModel: DetailsTableViewModelType {
    func getListMenu() -> Restaurant {
        listDetails
    }
}
