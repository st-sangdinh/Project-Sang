//
//  DetailHistoryViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 11/05/2022.
//

import Foundation
protocol DetailHistoryViewModelType {
    func getItemOrder(at index: IndexPath) -> ItemOrder
    func getResName() -> String
    func getDataTime() -> Date?
    func numberOfRowsInSection() -> Int
    func totalDiscount() -> Int
    func priceDiscount(at index: IndexPath) -> Int
}

class DetailHistoryViewModel {
    var resName: String
    var dateTime: Date?
    var resMenu: [ItemOrder]

    init(resName: String = "", resMenu: [ItemOrder], dateTime: Date?) {
        self.resName = resName
        self.resMenu = resMenu
        self.dateTime = dateTime
    }
}

extension DetailHistoryViewModel: DetailHistoryViewModelType {
    func getDataTime() -> Date? {
        return dateTime
    }

    func getResName() -> String {
        return resName
    }

    func totalDiscount() -> Int {
        var totalDiscount: Int = 0
        resMenu.forEach({ item in
            let amout = item.amout
            let price = item.menuItem.price
            let discount = item.menuItem.discount
            let priceDiscount = Int(Float(price) * (Float(Float(100 - discount) / 100)))
            totalDiscount += priceDiscount * amout
        })
        return totalDiscount
    }

    func priceDiscount(at index: IndexPath) -> Int {
        let cart = resMenu[index.row]
        let price = cart.menuItem.price
        let discount = cart.menuItem.discount
        let priceDiscount = Float(price) * (Float(Float(100 - discount) / 100))
        return Int(priceDiscount)
    }

    func getItemOrder(at index: IndexPath) -> ItemOrder {
        return resMenu[index.row]
    }

    func numberOfRowsInSection() -> Int {
        return resMenu.count
    }
}
