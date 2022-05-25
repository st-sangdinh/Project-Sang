//
//  AlertCartViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 25/05/2022.
//

import UIKit
protocol AlertCartViewControllerDelegate: AnyObject {
    func viewController(view: AlertCartViewController, action: AlertCartViewController.Action)
}

class AlertCartViewController: UIViewController {

    enum Action {
        case clearCart
    }

    weak var delegate: AlertCartViewControllerDelegate?

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var clearLabel: UILabel!
    @IBOutlet weak var canceView: UIButton!
    @IBOutlet weak var okView: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        // Do any additional setup after loading the view.
    }

    func configView() {
        clearLabel.font = UIFont.boldSystemFont(ofSize: 17)

        contentView.layer.cornerRadius = 15
        contentView.layer.shadowColor = UIColor(red: 0.055, green: 0.498, blue: 0.239, alpha: 0.24).cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.bounds =  contentView.bounds
        contentView.layer.position = contentView.center

        canceView.layer.cornerRadius = 10
        canceView.layer.shadowColor = UIColor(red: 0.055, green: 0.498, blue: 0.239, alpha: 0.24).cgColor
        canceView.layer.shadowOpacity = 1
        canceView.layer.shadowRadius = 5
        canceView.layer.shadowOffset = CGSize(width: 0, height: 2)
        canceView.layer.bounds =  canceView.bounds
        canceView.layer.position = canceView.center

        okView.layer.cornerRadius = 10
        okView.layer.shadowColor = UIColor(red: 0.055, green: 0.498, blue: 0.239, alpha: 0.24).cgColor
        okView.layer.shadowOpacity = 1
        okView.layer.shadowRadius = 5
        okView.layer.shadowOffset = CGSize(width: 0, height: 2)
        okView.layer.bounds = okView.bounds
        okView.layer.position = okView.center
    }

    @IBAction func canceButton(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func okButton(_ sender: Any) {
        delegate?.viewController(view: self, action: .clearCart)
        dismiss(animated: true)
    }
}
