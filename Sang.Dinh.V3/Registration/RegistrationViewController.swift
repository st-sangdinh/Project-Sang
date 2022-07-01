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

    }

    @IBAction private func loginButton(_ sender: Any) {

    }
}
