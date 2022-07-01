//
//  RegistrationViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 29/06/2022.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        self.navigationController?.isNavigationBarHidden = true
    }

    func configView() {
        createAccountButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        createAccountButton.layer.cornerRadius = 12

        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginButton.layer.cornerRadius = 12
    }

    @IBAction func createAccountButton(_ sender: Any) {

    }

    @IBAction func loginButton(_ sender: Any) {

    }
}
