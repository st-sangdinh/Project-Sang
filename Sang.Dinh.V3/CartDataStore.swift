//
//  CartDataStore.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 19/05/2022.
//

import Foundation

protocol CartDataStoreType {
    func getCart() -> [ItemOrder]
    func getItemOrder(at index: Int) -> ItemOrder
    func appendCart(item: ItemOrder)
    func minusCart(at index: Int)
    func insertItemOrder(item: ItemOrder, index: Int)
    func removeItemOrder(item: ItemOrder, index: Int)
    func removeAll()
}

final class CartDataStore: CartDataStoreType {

    // Signleton
    static let shared = CartDataStore()
    private init() {}
    // Private properties
    private let standard = UserDefault.shared
    private let kCarts = "kCarts"

    func getCart() -> [ItemOrder] {
        let value = standard.getObjects(type: ItemOrder.self, key: kCarts)
        return value
    }

    func getItemOrder(at index: Int) -> ItemOrder {
        let result = getCart()
        return result[index]
    }

    func minusCart(at index: Int) {
        var result = standard.getObjects(type: ItemOrder.self, key: kCarts)
        if result[index].amout > 0 {
            result[index].amout -= 1
            standard.saveObject(result[index], forKey: kCarts)
        }
    }

    func appendCart(item: ItemOrder) {
        var result = standard.getObjects(type: ItemOrder.self, key: kCarts)
        result.append(item)
        standard.saveObjects(result, forKey: kCarts)
    }
    func insertItemOrder(item: ItemOrder, index: Int) {
        var result = standard.getObjects(type: ItemOrder.self, key: kCarts)
        result.insert(item, at: index)
        standard.saveObjects(result, forKey: kCarts)
    }

    func replaceItemOrder(item: ItemOrder, index: Int) {
        var result = standard.getObjects(type: ItemOrder.self, key: kCarts)
        result.remove(at: index)
        result.insert(item, at: index)
        standard.saveObjects(result, forKey: kCarts)
    }

    func removeItemOrder(item: ItemOrder, index: Int) {
        var result = standard.getObjects(type: ItemOrder.self, key: kCarts)
        result.remove(at: index)
        standard.saveObjects(result, forKey: kCarts)
    }

    func removeAll() {
        var result = standard.getObjects(type: ItemOrder.self, key: kCarts)
        result.removeAll()
        standard.saveObject(result, forKey: kCarts)
    }
}
