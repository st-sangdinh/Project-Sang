//
//  ForgetPasswordViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 06/07/2022.
//

import Foundation

protocol ForgetPasswordViewModelType {
    func setEmail(email: String)
    func isValid() -> Bool
    func checkEmail() -> String
    func viewModelForChangeNewPasswordViewController() -> ChangeNewPasswordViewModel
    func checkEmail(completion: @escaping Completion<User>)
}

final class ForgetPasswordViewModel {
    private var email: String = ""
    private var userRepository = UserRepository()
}

extension ForgetPasswordViewModel: ForgetPasswordViewModelType {

    func setEmail(email: String) {
        self.email = email
    }

    func isValid() -> Bool {
        if !email.isEmpty && checkRegexEmail() {
            return true
        } else if email.isEmpty && checkRegexEmail() {
            return false
        }
        return false
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

    func viewModelForChangeNewPasswordViewController() -> ChangeNewPasswordViewModel {
        return ChangeNewPasswordViewModel(email: self.email)
    }

    func checkEmail(completion: @escaping Completion<User>) {
        userRepository.getUser(email: self.email, completion: completion)
    }
}
