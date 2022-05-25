//
//  OrderViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 10/05/2022.
//

import UIKit

protocol OrderViewControllerDelegate: AnyObject {
    func viewController(supView: OrderViewController, action: OrderViewController.Action)
}

class OrderViewController: UIViewController, UITextFieldDelegate {
    enum Action {
        case addCart
    }

    var viewModel: OrderViewModel?
    var quantity: Int = 0
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var viewFooter: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quantityLable: UILabel!
    @IBOutlet weak var textField: UITextField!
    weak var delegate: OrderViewControllerDelegate?

    init(viewModel: OrderViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("BBBBB")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configView()
    }

    func configView() {
        subView.layer.cornerRadius = 20
        subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imgView.layer.cornerRadius = 20
        imgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        viewFooter.layer.cornerRadius = 20
        viewFooter.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewFooter.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.09).cgColor
        viewFooter.layer.shadowOpacity = 1
        viewFooter.layer.shadowRadius = 14
        viewFooter.layer.shadowOffset = CGSize(width: 0, height: -1)
        viewFooter.layer.bounds = viewFooter.bounds
        viewFooter.layer.position = viewFooter.center

        orderButton.layer.cornerRadius = 14

        nameLabel.text = viewModel?.getMenu().name
        priceLabel.text = "\(viewModel?.getMenu().price ?? 0) $ "
        descriptionLabel.text = viewModel?.getMenu().description
        imgView.downloaded(from: viewModel?.getMenu().imageUrl ?? "")
//        self.quantity = viewModel?.getMenu().number ?? 0
        textField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @IBAction func plusButton(_ sender: Any) {
        quantity += 1
        quantityLable.text = "\(quantity)"
    }

    @IBAction func minusButton(_ sender: Any) {
        if quantity > 0 {
            quantity -= 1
            quantityLable.text = "\(quantity)"
        }
    }

    @IBAction func orderButton(_ sender: Any) {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.number = quantity
        viewModel.note = textField.text ?? ""
        if quantity > 0 {
            dismiss(animated: true)
        }
        viewModel.saveCartData()
        delegate?.viewController(supView: self, action: .addCart)
    }
}
