//
//  CartViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 12/05/2022.
//

import UIKit

protocol CartViewControllerDelegate: AnyObject {
    func viewController(view: CartViewController, acction: CartViewController.Action)
}

class CartViewController: UIViewController {

    enum Action {
        case checkOut
        case updateCart
        case clearCart
    }

    var viewModel: CartViewModel
    var priceDiscount: Int = 0
    var totalAmout: Int = 0

    weak var delegate: CartViewControllerDelegate?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var checkOutView: UIView!
    @IBOutlet weak var totalItem: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var clear: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configTableView()
        loadCartData()
        // Do any additional setup after loading the view.
    }

    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configTableView() {
        tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CartTableViewCell")
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func configView() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        headerView.layer.cornerRadius = 20
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        footerView.layer.cornerRadius = 20
        footerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        footerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.09).cgColor
        footerView.layer.shadowOpacity = 1
        footerView.layer.shadowRadius = 14
        footerView.layer.shadowOffset = CGSize(width: 0, height: -1)
        footerView.layer.bounds = footerView.bounds
        footerView.layer.position = footerView.center

        checkOutView.layer.cornerRadius = 15
        checkOutView.layer.cornerRadius = 10
        checkOutView.layer.shadowColor = UIColor(red: 0.055, green: 0.498, blue: 0.239, alpha: 0.24).cgColor
        checkOutView.layer.shadowOpacity = 1
        checkOutView.layer.shadowRadius = 5
        checkOutView.layer.shadowOffset = CGSize(width: 0, height: 2)
        checkOutView.layer.bounds = checkOutView.bounds
        checkOutView.layer.position = checkOutView.center

    }

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func order(_ sender: Any) {
        viewModel.saveHistoryOrder()
        CartDataStore.shared.removeAll()
        delegate?.viewController(view: self, acction: .checkOut)
        dismiss(animated: true)
    }

    @IBAction func clearButton(_ sender: Any) {
        let viewController = AlertCartViewController()
        viewController.modalPresentationStyle = .overCurrentContext
        present(viewController, animated: true, completion: nil)
        viewController.delegate = self
    }

    func loadCartData() {
        let loadCart = viewModel.loadCart()
        totalItem.text = "\(CartDataStore.shared.getCart().count) Items"
        priceLabel.text = "\(loadCart) $"
    }
}

// MARK: - UITableViewDataSource
extension CartViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell
//        let cart = CartData.carts[indexPath.row]
        let cart = CartDataStore.shared.getItemOrder(at: indexPath.row)
        let priceDiscount = viewModel.priceDiscount(at: indexPath)
        let price = cart.menuItem.price
//        let discount = cart.menuItem.discount
//        let priceDiscount = CGFloat(price) * (CGFloat(CGFloat(100 - discount) / 100))
        cell?.setData(
            name: cart.menuItem.name,
            note: cart.notes, price: price,
            quantity: cart.amout,
            discount: priceDiscount )
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}

// MARK: - CartTableViewCellDelegate
extension CartViewController: CartTableViewCellDelegate {
    func viewCell(cell: CartTableViewCell, action: CartTableViewCell.Action) {
        switch action {
        case.minius:
            guard let indexPath = tableView.indexPath(for: cell) else { return  }
            var itemOrder = CartDataStore.shared.getItemOrder(at: indexPath.row)

            if itemOrder.amout > 0 {
                itemOrder.amout -= 1
                CartDataStore.shared.replaceItemOrder(item: itemOrder, index: indexPath.row)
//                priceLabel.text = "\(itemOrder.amout * itemOrder.menuItem.price) $"
                loadCartData()
                priceLabel.text = "\(viewModel.priceDiscount ) $"
                tableView.reloadData()
                delegate?.viewController(view: self, acction: .updateCart)
            } else if itemOrder.amout < 1 {
                CartDataStore.shared.removeItemOrder(item: itemOrder, index: indexPath.row)
                totalItem.text = "\(CartDataStore.shared.getCart().count) Items"
                tableView.reloadData()
            }

        case.plus:
            guard let indexPath = tableView.indexPath(for: cell) else { return  }
            var itemOrder = CartDataStore.shared.getItemOrder(at: indexPath.row)
            itemOrder.amout += 1
            CartDataStore.shared.replaceItemOrder(item: itemOrder, index: indexPath.row)
            loadCartData()
            priceLabel.text = "\(viewModel.priceDiscount ) $"
            tableView.reloadData()
            delegate?.viewController(view: self, acction: .updateCart )
        }
    }
}

// MARK: - AlertCartViewControllerDelegate
extension CartViewController: AlertCartViewControllerDelegate {
    func viewController(view: AlertCartViewController, action: AlertCartViewController.Action) {
        switch action {
        case.clearCart:
            CartDataStore.shared.removeAll()
            tableView.reloadData()
            delegate?.viewController(view: self, acction: .clearCart)
            totalItem.text = "\(0) Item"
            priceLabel.text = "\(0) $"
        }
    }
}
