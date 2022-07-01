//
//  RegistrationFirstViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 29/06/2022.
//

import UIKit
protocol RegistrationFirstViewControllerDelegate: AnyObject {
    func viewController(view: RegistrationFirstViewController, action: RegistrationFirstViewController.Action)
}

class RegistrationFirstViewController: UIViewController {

    enum ScreenChoose {
        case createAccount
        case login
    }

    enum Action {
        case forgetPassword
        case home
    }

    var viewModel: RegistrationFirstViewModelType = RegistrationFirstViewModel()

    @IBOutlet weak var fullNameView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var exitView: UIView!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var lineCreateAccount: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var lineLogin: UIView!

    @IBOutlet weak var fullNameTextField: TextField!

    @IBOutlet weak var emailTextField: TextField!

    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var heightFullNameConstrain: NSLayoutConstraint!

    weak var delegate: RegistrationFirstViewControllerDelegate?
    var statusView: ScreenChoose = .createAccount

       init(statusView: ScreenChoose) {
           super.init(nibName: "RegistrationFirstViewController", bundle: nil)
           self.statusView = statusView
       }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        updateView(status: statusView)
        textFieldChane()
        self.navigationController?.isNavigationBarHidden = true
    }

    func configView() {
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
    }

    func textFieldChane() {
        fullNameTextField.addTarget(self, action: #selector(fullNameTextFieldDidChange), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldChange), for: .editingChanged)
    }

    private func updateView(status: ScreenChoose ) {
        switch status {
        case .createAccount:
                lineLogin.isHidden = true
                lineCreateAccount.isHidden = false
                createAccountButton.tintColor = UIColor(red: 0.196, green: 0.718, blue: 0.408, alpha: 1)
                loginButton.tintColor =  UIColor(red: 0.537, green: 0.565, blue: 0.62, alpha: 1)
                heightFullNameConstrain.constant = 82
                forgetPasswordButton.isHidden = true
                fullNameView.isHidden = false
                registrationButton.titleLabel?.text = "Registration"

        case .login:
                lineCreateAccount.isHidden = true
                lineLogin.isHidden = false
                loginButton.tintColor =  UIColor(red: 0.196, green: 0.718, blue: 0.408, alpha: 1)
                createAccountButton.tintColor = UIColor(red: 0.537, green: 0.565, blue: 0.62, alpha: 1)
                heightFullNameConstrain.constant = 0
                forgetPasswordButton.isHidden  = false
                fullNameView.isHidden = true
                registrationButton.titleLabel?.text = "Login"
        }
    }

    @IBAction func createButton(_ sender: Any) {
        updateView(status: .createAccount)
    }

    @IBAction func loginButton(_ sender: Any) {
        updateView(status: .login)
    }

    @objc func fullNameTextFieldDidChange(_ textField: UITextField) {
        viewModel.setFullName(fullName: textField.text ?? "")
    }

    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        viewModel.setEmai(email: textField.text ?? "")
    }

    @objc func passwordTextFieldChange(_ textField: UITextField) {
        viewModel.setPassword(password: textField.text ?? "")
    }

    @IBAction func forgetPassword(_ sender: Any) {
        dismiss(animated: true)
        delegate?.viewController(view: self, action: .forgetPassword)
    }

    @IBAction func registrationButton(_ sender: Any) {
        delegate?.viewController(view: self, action: .home)

        // Change root window
//        (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = HomeViewController()
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
