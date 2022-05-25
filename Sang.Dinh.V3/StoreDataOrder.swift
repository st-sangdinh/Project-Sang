//
//  StoreDataOrder.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 19/05/2022.
//

import Foundation

protocol StoreDataOrderType {
    func getHistoryOrder() -> [HistoryOrder]
    func getHistoryOrder(at index: Int) -> HistoryOrder
    func insertHistoryOrder(item: HistoryOrder, index: Int)
    func appendHistoryOrder(item: HistoryOrder)
    func removeHistoryOrder(item: HistoryOrder, at index: Int)
    func replaceHistoryOrder(item: HistoryOrder, index: Int)
}

class StoreDataOrder: StoreDataOrderType {
    static let shared = StoreDataOrder()
    private init() {}

    private let standard = UserDefault.shared
    private let kOrder = "kOrder"
    func getHistoryOrder() -> [HistoryOrder] {
        let value = standard.getObjects(type: HistoryOrder.self, key: kOrder)
        return value
    }

    func getHistoryOrder(at index: Int) -> HistoryOrder {
        let result = getHistoryOrder()
        return result[index]
    }

    func insertHistoryOrder(item: HistoryOrder, index: Int) {
        var result = standard.getObjects(type: HistoryOrder.self, key: kOrder)
        result.insert(item, at: index)
        standard.saveObjects(result, forKey: kOrder)
    }

    func appendHistoryOrder(item: HistoryOrder) {
        var result = standard.getObjects(type: HistoryOrder.self, key: kOrder)
        result.append(item)
        standard.saveObjects(result, forKey: kOrder)
    }

    func replaceHistoryOrder(item: HistoryOrder, index: Int) {
        var result = standard.getObjects(type: HistoryOrder.self, key: kOrder)
        result[index] = item
        standard.saveObjects(result, forKey: kOrder)
    }

    func removeHistoryOrder(item: HistoryOrder, at index: Int) {
        var result = standard.getObjects(type: HistoryOrder.self, key: kOrder)
        result.remove(at: index)
        standard.saveObjects(result, forKey: kOrder)
    }
}
