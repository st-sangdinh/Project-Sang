//
//  ChangeNewPasswordViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 07/07/2022.
//

import Foundation

protocol ChangeNewPasswordViewModelType {
    func isValid() -> Bool
    func setPassword(newPassword: String)
    func setConfirmPasswrod(confirmPassword: String)
    func checkNewPassword() -> String
    func checkConfirmPassword() -> String
    func updatePassword()
}

final class ChangeNewPasswordViewModel {
    private var newPassword: String = ""
    private var confirmPassword: String = ""
    private var userRepository = UserRepository()
    private var email: String

    init(email: String = "") {
        self.email = email
    }
}

extension ChangeNewPasswordViewModel: ChangeNewPasswordViewModelType {
    func isValid() -> Bool {
        if newPassword.isEmpty && newPassword.count < 6 && confirmPassword != newPassword {
            return false
        } else if !newPassword.isEmpty && newPassword.count >= 6 && confirmPassword == newPassword {
            return true
        }
        return false
    }

    func setPassword(newPassword: String) {
        self.newPassword = newPassword
    }

    func setConfirmPasswrod(confirmPassword: String) {
        self.confirmPassword = confirmPassword
    }

    func checkNewPassword() -> String {
        if newPassword.isEmpty {
            return "Không được để trống"
        }
        if newPassword.count < 6 {
            return "Password phải trên 6 kí tự"
        }
        return ""
    }

    func checkConfirmPassword() -> String {
        if confirmPassword.isEmpty {
            return "Không được để trống"
        }
        if confirmPassword.count < 6 {
            return "Password phải trên 6 kí tự"
        }
        if confirmPassword != newPassword {
            return "Nhập lại không trùng khớp"
        }
        return ""
    }

    func updatePassword() {
        userRepository.updatePassword(user: User(fullName: "", email: self.email, passWord: self.confirmPassword))
    }
}
