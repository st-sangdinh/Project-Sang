//
//  RegistrationFirstViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 29/06/2022.
//

import UIKit

final class RegistrationFirstViewController: UIViewController {

    enum ScreenChoose {
        case createAccount
        case login
    }

    enum Action {
        case forgetPassword
        case home
    }

    var viewModel: RegistrationFirstViewModelType = RegistrationFirstViewModel()

    @IBOutlet private weak var loader: Loader!
    @IBOutlet private weak var fullNameView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var exitView: UIView!
    @IBOutlet private weak var createAccountButton: UIButton!
    @IBOutlet private weak var lineCreateAccount: UIView!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var lineLogin: UIView!
    @IBOutlet private weak var fullNameTextField: TextField!
    @IBOutlet private weak var fullNameError: UILabel!
    @IBOutlet private weak var emailTextField: TextField!
    @IBOutlet private weak var emailError: UILabel!
    @IBOutlet private weak var passwordTextField: TextField!
    @IBOutlet private weak var passwordError: UILabel!
    @IBOutlet private weak var forgetPasswordButton: UIButton!
    @IBOutlet private weak var registrationButton: UIButton!
    @IBOutlet private weak var signUpView: UIView!
    @IBOutlet private weak var heightFullNameConstrain: NSLayoutConstraint!

    var statusView: ScreenChoose

    init(statusView: ScreenChoose) {
           self.statusView = statusView

           super.init(nibName: "RegistrationFirstViewController", bundle: nil)
       }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        updateView()
        textFieldChane()
        self.navigationController?.isNavigationBarHidden = true
    }

    private func configView() {
        containerView.layer.cornerRadius = 30
        exitView.layer.cornerRadius = exitView.bounds.height / 2
        createAccountButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

        fullNameTextField.layer.borderWidth = 1
        fullNameTextField.layer.borderColor = UIColor(red: 0.745, green: 0.773, blue: 0.82, alpha: 1).cgColor
        fullNameTextField.layer.cornerRadius = 12

        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(red: 0.745, green: 0.773, blue: 0.82, alpha: 1).cgColor
        emailTextField.layer.cornerRadius = 12

        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(red: 0.745, green: 0.773, blue: 0.82, alpha: 1).cgColor
        passwordTextField.layer.cornerRadius = 12

        forgetPasswordButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

        registrationButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        registrationButton.layer.cornerRadius = 12
        signUpView.layer.cornerRadius = 12
        registrationButton.tintColor =  UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1)
    }

    private func textFieldChane() {
        fullNameTextField.addTarget(self, action: #selector(fullNameTextFieldDidChange), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldChange), for: .editingChanged)
    }

    private func updateView() {
        switch statusView {
        case .createAccount:
                lineLogin.isHidden = true
                lineCreateAccount.isHidden = false
                createAccountButton.tintColor = UIColor(red: 0.196, green: 0.718, blue: 0.408, alpha: 1)
                loginButton.tintColor =  UIColor(red: 0.537, green: 0.565, blue: 0.62, alpha: 1)
                heightFullNameConstrain.constant = 102
                forgetPasswordButton.isHidden = true
                fullNameView.isHidden = false
                registrationButton.setTitle("Registration", for: .normal)
                fullNameTextField.text = ""
                fullNameError.text = ""
                emailTextField.text = ""
                emailError.text = ""
                passwordTextField.text = ""
                passwordError.text = ""

        case .login:
                lineCreateAccount.isHidden = true
                lineLogin.isHidden = false
                loginButton.tintColor =  UIColor(red: 0.196, green: 0.718, blue: 0.408, alpha: 1)
                createAccountButton.tintColor = UIColor(red: 0.537, green: 0.565, blue: 0.62, alpha: 1)
                heightFullNameConstrain.constant = 0
                forgetPasswordButton.isHidden  = false
                fullNameView.isHidden = true
                registrationButton.setTitle("Login", for: .normal)
                emailTextField.text = ""
                emailError.text = ""
                passwordTextField.text = ""
                passwordError.text = ""
        }
    }

    @IBAction private func createButton(_ sender: Any) {
        statusView = .createAccount
        updateView()
    }

    @IBAction private func loginButton(_ sender: Any) {
        statusView = .login
        updateView()
    }

    @objc private func fullNameTextFieldDidChange(_ textField: UITextField) {
        viewModel.setFullName(fullName: textField.text ?? "")
        updateButton()
        fullNameError.text = viewModel.checkFullName()
    }

    @objc private func emailTextFieldDidChange(_ textField: UITextField) {
        viewModel.setEmai(email: textField.text ?? "")
        updateButton()
        emailError.text = viewModel.checkEmail()
    }

    @objc private func passwordTextFieldChange(_ textField: UITextField) {
        viewModel.setPassword(password: textField.text ?? "")
        updateButton()
        passwordError.text = viewModel.checkPass()
    }

    @IBAction private func forgetPassword(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction private func registrationButton(_ sender: Any) {
        switch statusView {
        case .createAccount:
                if viewModel.isValidCreate() {
                    createUser()
                } else {
                    let alertController = UIAlertController(
                        title: "Lỗi",
                        message: "Vui lòng nhập các trường trên",
                        preferredStyle: .alert
                    )
                    let action = UIAlertAction(title: "OK", style: .default)
                    alertController.addAction(action)
                    self.present(alertController, animated: true)
                }
        case .login:
                if viewModel.isValid() {
                    login()
                }
        }
    }

    private func updateButton() {
        registrationButton.isEnabled = viewModel.isValid()
        if viewModel.isValid() {
            registrationButton.backgroundColor = UIColor(red: 0.196, green: 0.718, blue: 0.408, alpha: 1)
            registrationButton.tintColor = .white
        } else {
            registrationButton.backgroundColor = UIColor(red: 0.957, green: 0.957, blue: 0.957, alpha: 1)
            registrationButton.tintColor =  UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1)
        }
      }

    private func login() {
        loader.startAnimating()
        viewModel.login(completion: {[weak self] result in
            guard let this = self else { return }
            this.loader.stopAnimating()
            switch result {
            case .success:
                    this.dismiss(animated: true)
                    // Change root window
                    (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = TabbarViewController()
            case .failure(let error):
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

    private func createUser() {
        viewModel.creatUser(completion: {[weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                    this.dismiss(animated: true)
            case .failure(let error):
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

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
