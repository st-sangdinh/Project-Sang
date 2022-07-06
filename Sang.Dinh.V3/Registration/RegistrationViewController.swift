//
//  RegistrationViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 29/06/2022.
//

import UIKit

final class RegistrationViewController: UIViewController {

    @IBOutlet private weak var createAccountButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        self.navigationController?.isNavigationBarHidden = true
    }

    private func configView() {
        createAccountButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        createAccountButton.layer.cornerRadius = 12

        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginButton.layer.cornerRadius = 12
    }

    @IBAction private func createAccountButton(_ sender: Any) {
        let viewController = RegistrationFirstViewController(statusView: .createAccount)
            present(viewController, animated: true)
    }

    @IBAction private func loginButton(_ sender: Any) {
        let viewController = RegistrationFirstViewController(statusView: .login)
            present(viewController, animated: true)
        viewController.delegate = self
    }
}

extension RegistrationViewController: RegistrationFirstViewControllerDelegate {
    func viewController(view: RegistrationFirstViewController, action: RegistrationFirstViewController.Action) {
        switch action {
            case.forgetPassword:
                let viewController = ForgetPasswordViewController()
                navigationController?.pushViewController(viewController, animated: true)
        }
    }


}
