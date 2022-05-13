//
//  BookingViewModle.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 11/05/2022.
//

import Foundation

class BookingViewModel {
    
    func makeVC(indexPath: IndexPath) -> DetailHistoryViewModel {
        let name = StoreOrderData.histories[indexPath.row].nameStore
        let dateTime = StoreOrderData.histories[indexPath.row].orderdDateTime
        let menu = StoreOrderData.histories[indexPath.row].orderedItems
        let vm = DetailHistoryViewModel(resName: name, resMenu: menu, dateTime: dateTime)
        return vm
    }
    
}
