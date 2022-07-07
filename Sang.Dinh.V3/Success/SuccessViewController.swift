//
//  SuccessViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 07/07/2022.
//

import UIKit

final class SuccessViewController: UIViewController {

    @IBOutlet private weak var signinButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        signinButton.layer.cornerRadius = 12
    }

    @IBAction private func signinButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }


}
