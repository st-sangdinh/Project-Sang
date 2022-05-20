//
//  BookingViewModle.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 11/05/2022.
//

import Foundation

class BookingViewModel {
    
    func makeVC(indexPath: IndexPath) -> DetailHistoryViewModel {
        let storeDataOreder = StoreDataOrder.shared.getHistoryOrder(at: indexPath.row)
        let name = storeDataOreder.nameStore
        let dateTime = storeDataOreder.orderdDateTime
        let menu = storeDataOreder.orderedItems
        let vm = DetailHistoryViewModel(resName: name, resMenu: menu, dateTime: dateTime)
        return vm
    }
    
}
