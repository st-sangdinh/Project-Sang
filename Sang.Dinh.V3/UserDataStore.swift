//
//  UserDataStore.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 05/07/2022.
//

import Foundation

protocol UserDataStoreType {
    func getUsers() -> [User]
    func setUser(item: User)
    func updateUser(user: User)
}

class UserDataStore: UserDataStoreType {
    static let shared = UserDataStore()
    private init() {}
    // Private properties
    private let standard = UserDefault.shared
    private let kUser = "kUser"

    func setUser(item: User) {
        var result = standard.getObjects(type: User.self, key: kUser)
        result.append(item)
        standard.saveObjects(result, forKey: kUser)
    }

    func getUsers() -> [User] {
        let user = standard.getObjects(type: User.self, key: kUser)
        return user
    }

    func updateUser(user: User) {
        var users = standard.getObjects(type: User.self, key: kUser)
        if let index = users.firstIndex(where: { $0.email == user.email }) {
            users[index].passWord = user.passWord
  
        }
        standard.saveObjects(users, forKey: kUser)
    }

}
