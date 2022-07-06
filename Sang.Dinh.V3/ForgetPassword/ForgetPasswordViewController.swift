//
//  ForgetPasswordViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 06/07/2022.
//

import UIKit

final class ForgetPasswordViewController: UIViewController {

    var viewModel: ForgetPasswordViewModelType = ForgetPasswordViewModel()

    @IBOutlet private weak var emailTextField: TextField!
    @IBOutlet private weak var emailError: UILabel!
    @IBOutlet private weak var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        textFieldChane()
    }

    private func configView() {
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(red: 0.745, green: 0.773, blue: 0.82, alpha: 1).cgColor
        emailTextField.layer.cornerRadius = 12
        submitButton.layer.cornerRadius = 12
        submitButton.tintColor =  UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1)
    }

    private func textFieldChane() {
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
    }

    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        viewModel.setEmail(email: textField.text ?? "")
        updateButton()
        emailError.text = viewModel.checkEmail()
    }

    @IBAction private func siginButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    private func updateButton() {
        submitButton.isEnabled = viewModel.isValid()
        if viewModel.isValid() {
            submitButton.backgroundColor = UIColor(red: 0.196, green: 0.718, blue: 0.408, alpha: 1)
            submitButton.tintColor = .white
        } else {
            submitButton.backgroundColor = UIColor(red: 0.957, green: 0.957, blue: 0.957, alpha: 1)
            submitButton.tintColor =  UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1)
        }
    }

    @IBAction private func submitButtonTochUp(_ sender: Any) {
        if viewModel.isValid() {
            forgetPassword()
        }
    }

    private func forgetPassword() {
        viewModel.checkEmail(completion: {[weak self] result in
            guard let this = self else { return }
            switch result {
                case.success:
                    print("Thồng canh")
                case.failure(let error):
                    let alertController = UIAlertController(
                        title: "Lỗi",
                        message: error.localizedDescription,
                        preferredStyle: .alert
                    )
                    let action = UIAlertAction(title: "OK", style: .default)
                    alertController.addAction(action)
                    this.present(alertController, animated: true)
            }
        })
    }
}
