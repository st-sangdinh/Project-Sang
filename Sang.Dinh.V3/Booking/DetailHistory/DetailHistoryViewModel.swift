//
//  DetailHistoryViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 11/05/2022.
//

import Foundation

class DetailHistoryViewModel {
    
    var resName: String
    var dateTime: Date?
    var resMenu: [ItemOrder]?
    
    init(resName: String = "", resMenu: [ItemOrder]? , dateTime: Date?) {
        self.resName = resName
        self.resMenu = resMenu
        self.dateTime = dateTime
    }
    
}
