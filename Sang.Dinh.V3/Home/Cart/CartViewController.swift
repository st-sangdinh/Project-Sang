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
        case updateCart(amout: Int)
    }
    
    
    var viewModel: CartViewModel?
    var a: Int = 0
    
    weak var delegate: CartViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var checkOutView: UIView!
    @IBOutlet weak var totalItem: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        configTableView()
        // Do any additional setup after loading the view.
    }
    
    init(viewModel: CartViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configTableView() {
        tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        tableView.dataSource = self
        
        totalItem.text = "\(CartData.carts.count) Items"
        priceLabel.text = "\(viewModel?.price ?? 0) $"
    }
        
    
    func configView() {
        headerView.layer.cornerRadius = 20
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
        footerView.layer.cornerRadius = 20
        footerView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
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
        viewModel?.saveHistoryOrder()
        CartData.carts.removeAll()
        delegate?.viewController(view: self, acction: .checkOut)
        dismiss(animated: true)
    }
    
    
}

extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CartData.carts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell
        let cart = CartData.carts[indexPath.row]
        cell?.setData(name: cart.menuItem.name, note: cart.notes, price: cart.menuItem.price, quantity: cart.amout)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}

extension CartViewController: CartTableViewCellDelegate {
    func viewCell(cell: CartTableViewCell, action: CartTableViewCell.Action) {
        switch action {
        case.minius:
            guard let indexPath = tableView.indexPath(for: cell) else { return  }
         
            CartData.carts[indexPath.row].amout -= 1
            tableView.reloadData()
            delegate?.viewController(view: self, acction: .updateCart(amout:  CartData.carts[indexPath.row].amout))
            
        case.plus:
            guard let indexPath = tableView.indexPath(for: cell) else { return  }
            CartData.carts[indexPath.row].amout += 1
            tableView.reloadData()
            delegate?.viewController(view: self, acction: .updateCart(amout:  CartData.carts[indexPath.row].amout))

        }
    }
}
