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
              viewController.delegate = self
    }

    @IBAction private func loginButton(_ sender: Any) {
        let viewController = RegistrationFirstViewController(statusView: .login)
                present(viewController, animated: true)
                viewController.delegate = self
    }
}

extension RegistrationViewController: RegistrationFirstViewControllerDelegate {
    func viewController(
        view: RegistrationFirstViewController,
        action: RegistrationFirstViewController.Action) {
            switch action {
            case .forgetPassword:
                    break
//                    let viewController = ForgetPasswordViewController()
//                    navigationController?.pushViewController(viewController, animated: true)
            case .home:
                    view.viewModel.login(completion: {[weak self] result in
                        guard let this = self else { return }
                        switch result {
                        case .success:
//                                let viewController = TabbarViewController()
                                this.dismiss(animated: true)
//                                this.navigationController?.pushViewController(viewController, animated: true)
                                (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = TabbarViewController()
                        case .failure(let error):
                                let alertController = UIAlertController(
                                    title: "Error",
                                    message: error.localizedDescription,
                                    preferredStyle: .alert
                                )
                                let action = UIAlertAction(title: "OK", style: .default)
                                alertController.addAction(action)
                                view.present(alertController, animated: true)
                        }
                    })
            }
        }
    }

