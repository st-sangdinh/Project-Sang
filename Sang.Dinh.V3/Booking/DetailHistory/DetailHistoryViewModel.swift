//
//  DetailHistoryViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 11/05/2022.
//

import Foundation

class DetailHistoryViewModel {
    
    var resName: String
    var resMenu: [ItemOrder]?
    
    init(resName: String = "", resMenu: [ItemOrder]?) {
        self.resName = resName
        self.resMenu = resMenu
    }
    
}
