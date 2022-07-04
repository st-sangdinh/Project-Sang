//
//  RegistrationFirstViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 30/06/2022.
//

import Foundation

protocol RegistrationFirstViewModelType {
    func setFullName(fullName: String)
    func setEmai(email: String)
    func setPassword(password: String)
    func isValid() -> Bool
    func checkLogin() -> Bool
    func login(completion: @escaping Completion<User>)
}

final class RegistrationFirstViewModel {
    private var fullName: String = ""
    private var email: String = ""
    private var password: String = ""
    private var userRepository = UserRepository()
}

extension RegistrationFirstViewModel: RegistrationFirstViewModelType {

    func setFullName(fullName: String) {
        self.fullName = fullName
    }

    func setEmai(email: String) {
        self.email = email
    }

    func setPassword(password: String) {
        self.password = password
    }

    func isValid() -> Bool {
        if !password.isEmpty && !email.isEmpty {
            return true
        } else if password.isEmpty && email.isEmpty {
            return false
        }
        return true
      }

    func checkLogin() -> Bool {
        for user in userRepository.users {
            if user.email == self.email && user.passWord == self.password {
                return true
            }
        }
        return false
    }

    private func validate() -> Error? {
        if email.isEmpty {
            return NSError(
                domain: "Booking", code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Email không được để trống"]
            )
        }
        if password.isEmpty {
            return NSError(
                domain: "Booking", code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Password không được để trống"]
            )
        }
        return nil
    }

    func login(completion: @escaping Completion<User>) {
        if let error = validate() {
            completion(.failure(error))
        } else {
            userRepository.login(
                fullName: self.fullName,
                email: self.email,
                password: self.password,
                completion: completion)
        }
    }
}
