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
    func isValidCreate() -> Bool 
    func checkFullName() -> String
    func checkEmail() -> String
    func checkPass() -> String
    func login(completion: @escaping Completion<User>)
    func creatUser(completion: @escaping Completion<Void>)
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
        if  !password.isEmpty && !email.isEmpty {
            return true
        } else if password.isEmpty && email.isEmpty {
            return false
        }
        return false
    }

    func isValidCreate() -> Bool {
        if  !fullName.isEmpty && !password.isEmpty && !email.isEmpty {
            return true
        } else if fullName.isEmpty && password.isEmpty && email.isEmpty {
            return false
        }
        return false
    }

    func checkFullName() -> String {
        if fullName.isEmpty {
            return "FullName không được để trống "
        }
        return ""
    }

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

    func creatUser(completion: @escaping Completion<Void>) {
        userRepository.createUser(user: User(fullName: self.fullName, email: self.email, passWord: self.password), completion: completion)
    }
}
