//
//  DetailsTableViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 09/05/2022.
//

import Foundation

protocol DetailsTableViewModelType {
    func getListMenu() -> ListMenu
}


class DetailsTableViewModel {
    var listDetails: ListMenu
    
    init(listDetails: ListMenu) {
        self.listDetails = listDetails
    }
}


extension DetailsTableViewModel: DetailsTableViewModelType {
    
    func getListMenu() -> ListMenu {
        listDetails
    }
}
