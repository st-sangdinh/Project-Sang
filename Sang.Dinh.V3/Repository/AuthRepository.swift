//
//  AuthRepository.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 30/06/2022.
//

import Foundation

struct User {
    var fullName: String
    var email: String
    var passWord: String
}

class UserRepository {
    var users: [User] = [User(fullName: "", email: "sang", passWord: "Sang123@"),
                         User(fullName: "", email: "sang1", passWord: "Sang124@"),
                         User(fullName: "", email: "sang2", passWord: "Sang124@")]

    func login(fullName: String, email: String, password: String, completion: @escaping Completion<User>) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            if let user = self?.users.first(where: {$0.email == email && $0.passWord == password}) {
                completion(.success(user))
            } else {
                let error = NSError(domain: "Demo.Sang", code: 1,
                                    userInfo: [NSLocalizedDescriptionKey: "UserName hoặc PassWord sai"])
                completion(.failure(error))
            }
        }
    }
}
