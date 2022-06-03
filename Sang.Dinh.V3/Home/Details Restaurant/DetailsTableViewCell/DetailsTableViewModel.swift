//
//  DetailsTableViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 09/05/2022.
//

import Foundation

protocol DetailsTableViewModelType {
    func getListMenu() -> Restaurant
    func numberOfItemsInSection() -> Int
}

class DetailsTableViewModel {
    var listDetails: Restaurant

    init(listDetails: Restaurant) {
        self.listDetails = listDetails
    }
}

extension DetailsTableViewModel: DetailsTableViewModelType {
    func numberOfItemsInSection() -> Int {
        listDetails.photos.count
    }
    func getListMenu() -> Restaurant {
        listDetails
    }
}
