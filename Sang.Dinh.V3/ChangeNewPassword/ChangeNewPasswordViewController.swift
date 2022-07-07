//
//  ChangeNewPasswordViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 06/07/2022.
//

import UIKit

final class ChangeNewPasswordViewController: UIViewController {

    var viewModel: ChangeNewPasswordViewModelType = ChangeNewPasswordViewModel()

    @IBOutlet private weak var newPassTextField: TextField!
    @IBOutlet private weak var newPassError: UILabel!
    @IBOutlet private weak var confirmPassTextField: TextField!
    @IBOutlet private weak var confirmPassError: UILabel!
    @IBOutlet private weak var changePassButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        textFieldChange()
    }

    private func configView() {
        newPassTextField.layer.borderWidth = 1
        newPassTextField.layer.borderColor = UIColor(red: 0.745, green: 0.773, blue: 0.82, alpha: 1).cgColor
        newPassTextField.layer.cornerRadius = 12

        confirmPassTextField.layer.borderWidth = 1
        confirmPassTextField.layer.borderColor = UIColor(red: 0.745, green: 0.773, blue: 0.82, alpha: 1).cgColor
        confirmPassTextField.layer.cornerRadius = 12

        changePassButton.layer.cornerRadius = 12
        changePassButton.tintColor =  UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1)
    }
    @IBAction private func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    private func textFieldChange() {
        newPassTextField.addTarget(self, action: #selector(newPassTextFieldChange), for: .editingChanged)
        confirmPassTextField.addTarget(self, action: #selector(confirmPassTextFieldChange), for: .editingChanged)
    }

    @objc private func newPassTextFieldChange(_ textField: UITextField) {
        viewModel.setPassword(newPassword: textField.text ?? "")
        updateButton()
        newPassError.text = viewModel.checkNewPassword()
    }

    @objc private func confirmPassTextFieldChange(_ textField: UITextField) {
        viewModel.setConfirmPasswrod(confirmPassword: textField.text ?? "")
        updateButton()
        confirmPassError.text = viewModel.checkConfirmPassword()
    }

    @IBAction private func changePassButton(_ sender: Any) {
        if viewModel.isValid() {
            viewModel.updatePassword()
            let viewController = SuccessViewController()
            navigationController?.pushViewController(viewController, animated: true
            )
        }
    }

    private func updateButton() {
        changePassButton.isEnabled = viewModel.isValid()
        if viewModel.isValid() {
            changePassButton.backgroundColor = UIColor(red: 0.196, green: 0.718, blue: 0.408, alpha: 1)
            changePassButton.tintColor = .white
        } else {
            changePassButton.backgroundColor = UIColor(red: 0.957, green: 0.957, blue: 0.957, alpha: 1)
            changePassButton.tintColor =  UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1)
        }
    }
}
