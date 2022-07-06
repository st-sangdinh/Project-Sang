//
//  AuthRepository.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 30/06/2022.
//

import Foundation

struct User: Codable {
    var fullName: String
    var email: String
    var passWord: String
}


class UserRepository {
//    var users: [User] = [User(fullName: "", email: "rinsang@gmail.com", passWord: "Sang123@"),
//                         User(fullName: "", email: "rinsang2@gmail.com", passWord: "Sang124@"),
//                         User(fullName: "", email: "sang@gmail.com", passWord: "Sang124@")]

    func login(fullName: String, email: String, password: String, completion: @escaping Completion<User>) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            let users = UserDataStore.shared.getUsers()
            if let user = users.first(where: {$0.email == email && $0.passWord == password}) {
                completion(.success(user))
            } else {
                let error = NSError(domain: "Demo.Sang", code: 1,
                                    userInfo: [NSLocalizedDescriptionKey: "UserName hoặc PassWord sai"])
                completion(.failure(error))
            }
        }
    }

    func register(user: User, completion: @escaping Completion<Void>) {
        let users = UserDataStore.shared.getUsers()
        if let _ = users.first(where: {$0.email == user.email}) {
            let error = NSError(domain: "Demo.Sang", code: 1,
                                userInfo: [NSLocalizedDescriptionKey: "Email đã trùng"])
            completion(.failure(error))
        } else {
            UserDataStore.shared.setUser(item: user)
            completion(.success(Void()))
        }
    }

    func getUser(email: String, completion: @escaping Completion<User>) {
        let users = UserDataStore.shared.getUsers()
        if let user = users.first(where: {$0.email == email}) {
            completion(.success(user))
        } else {
            let error = NSError(domain: "Demo.Sang", code: 1,
                                userInfo: [NSLocalizedDescriptionKey: "Email không tồn tại, vui lòng kiểm tra lại "])
            completion(.failure(error))
        }
    }

    func updatePassword(user: User) {
        
    }
}
