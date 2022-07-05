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
//    func checkLogin() -> Bool
    func checkEmail() -> String
    func checkPass() -> String
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
        return false
      }

//    func checkLogin() -> Bool {
//        for user in userRepository.users {
//            if user.email == self.email && user.passWord == self.password {
//                return true
//            }
//        }
//        return false
//    }

    func checkEmail() -> String {
        if email.isEmpty {
            return "Email không được để trống"
        }
        return checkRegexEmail() ? "" : "Email không hợp lệ"
    }

    private func checkRegexEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self.email)
    }

    func checkPass() -> String {
        if password.isEmpty {
            return "Password không được để trống"
        }
        if password.count < 6 {
            return "Password phải trên 6 kí tự"
        }
        return ""
    }

    func login(completion: @escaping Completion<User>) {
//        if let error = validate() {
//            completion(.failure(error))
//        } else {
            userRepository.login(
                fullName: self.fullName,
                email: self.email,
                password: self.password,
                completion: completion)
//        }
    }
}
