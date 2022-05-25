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
    var listBooking: [Restaurant] = []

    init(listBooking: [Restaurant] = []) {
        self.listBooking = listBooking
    }
}

extension SeeALLViewModel: SeeALLViewModelType {
    func viewMdelForDetailsView(in indexPath: IndexPath) -> DetailsViewModel {
        return DetailsViewModel(listDetails: listBooking[indexPath.item])
    }

    func getListMenu() -> [Restaurant] {
        listBooking
    }

    func getMenu(at indexPath: IndexPath) -> Restaurant {
        listBooking[indexPath.item]
    }
}
