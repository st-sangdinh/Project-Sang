//
//  UserDataStore.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 05/07/2022.
//

import Foundation

protocol UserDataStoreType {
    func getUser() -> [User]
    func appendUser(item: User)
}

class UserDataStore: UserDataStoreType {
    static let shared = UserDataStore()
    private init() {}
    // Private properties
    private let standard = UserDefault.shared
    private let kUser = "kUser"

    func appendUser(item: User) {
        var result = standard.getObjects(type: User.self, key: kUser)
        result.append(item)
        standard.saveObjects(result, forKey: kUser)
    }

    func getUser() -> [User] {
        let user = standard.getObjects(type: User.self, key: kUser)
        return user
    }

}
