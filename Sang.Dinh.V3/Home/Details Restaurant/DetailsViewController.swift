//
//  DetailsViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 05/05/2022.
//

import UIKit

class DetailsViewController: UIViewController {

    var viewModel: DetailsViewModelType

    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var quantityCart: UILabel!
    @IBOutlet weak var viewCheckOut: UIView!
    @IBOutlet weak var labelCheckOut: UILabel!

    var priceDiscount: Int = 0
    var totalAmout: Int = 0
    var discount: Int = 0

    init(viewModel: DetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true
        //  any additional setup after loading the view.
        configTableView()
        configView()
        navigationView.layer.cornerRadius = 20
        navigationView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true

        if CartDataStore.shared.getCart().isEmpty {
            footerView.isHidden = true
        } else {
            loadCartData()
            footerView.isHidden = false
        }
        loadCartData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    func configTableView() {
        tableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "DetailsTableViewCell")
        tableView.register(UINib(nibName: "RecommendedTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "RecommendedTableViewCell")
        tableView.register(UINib(nibName: "DetailsHeaderViewCell", bundle: nil),
                           forHeaderFooterViewReuseIdentifier: "DetailsHeaderViewCell")
        tableView.dataSource = self
        tableView.delegate = self

    }

    func configView() {
        footerView.layer.cornerRadius = 20
        footerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        footerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.09).cgColor
        footerView.layer.shadowOpacity = 1
        footerView.layer.shadowRadius = 14
        footerView.layer.shadowOffset = CGSize(width: 0, height: -1)
        footerView.layer.bounds = footerView.bounds
        footerView.layer.position = footerView.center

        cartView.layer.cornerRadius = 10
        cartView.layer.shadowColor = UIColor(red: 0.055, green: 0.498, blue: 0.239, alpha: 0.24).cgColor
        cartView.layer.shadowOpacity = 1
        cartView.layer.shadowRadius = 5
        cartView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cartView.layer.bounds = cartView.bounds
        cartView.layer.position = cartView.center

        viewCheckOut.layer.cornerRadius = 10
        viewCheckOut.layer.shadowColor = UIColor(red: 0.055, green: 0.498, blue: 0.239, alpha: 0.24).cgColor
        viewCheckOut.layer.shadowOpacity = 1
        viewCheckOut.layer.shadowRadius = 5
        viewCheckOut.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewCheckOut.layer.bounds = viewCheckOut.bounds
        viewCheckOut.layer.position = viewCheckOut.center

    }

    func loadCartData() {
        priceDiscount = 0
        totalAmout = 0
        CartDataStore.shared.getCart().forEach { item in
            let price = item.menuItem.price
            var discount = item.menuItem.discount
            let amout = item.amout
            totalAmout += item.amout
//            totalPrice += item.amout * item.menuItem.price
            discount = Int(CGFloat(price) * (CGFloat(CGFloat(100 - discount) / 100)))
            priceDiscount += discount * amout
        }
        labelCheckOut.text = "Check Out \(priceDiscount) $"
        quantityCart.text = "\(totalAmout) "

    }

    func reloadData() {
        tableView.reloadData()
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func checkOut(_ sender: Any) {
        let viewController = CartViewController(viewModel: viewModel.viewModelForCart(price: priceDiscount))
        viewController.delegate = self
        navigationController?.present(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension DetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 1
//        return viewModel.getListMenu().menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "DetailsTableViewCell", for: indexPath) as? DetailsTableViewCell
            let menu = viewModel.getListMenu()
            cell?.setData(name: menu.name, address: menu.address.address)
            cell?.viewModel = viewModel.viewModelForDetails(in: indexPath)
//            cell?.didSelect = {
//                let viewController = MapViewController(viewModel: self.viewModel.viewModelForMap())
//                self.navigationController?.pushViewController(viewController, animated: true)
//            }
            cell?.delegate = self
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "RecommendedTableViewCell", for: indexPath) as? RecommendedTableViewCell

//            let menu = viewModel.getMenu(at: indexPath)
//
//            cell?.setData(image: menu.imageUrl, name: menu.name, description: menu.description)
//
            cell?.delegate = self
            cell?.viewModel = viewModel.viewModelForRecommended()
            return cell ?? UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: "DetailsHeaderViewCell") as? DetailsHeaderViewCell
            headerView?.delegate = self
            return headerView ?? UIView()
        }
        return UIView()
    }
}

// MARK: - UITableViewDelegate
extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 75
        }
        return .leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 210
        }
        return 360
    }

}
//extension DetailsViewController: ListDetailsTableViewCellDelegate {
//    func cell(subView: ListDetailsTableViewCell) {
//        guard let indexPath = tableView.indexPath(for: subView) else { return }
//        let vc = OrderViewController(viewModel: self.viewModel.viewModelForOrder(in: indexPath))
//        vc.delegate = self
////        vc.presentationController?.delegate = self
//        self.present(vc, animated: true)
//    }
//}

// MARK: - RecommendedTableViewCellDelegate
extension DetailsViewController: RecommendedTableViewCellDelegate {
    func viewCell(view: RecommendedTableViewCell, action: RecommendedTableViewCell.Action) {
        switch action {
        case .item(let index):
//            guard let indexPath = tableView.indexPath(for: view) else { return }
            let viewController = OrderViewController(
                viewModel: self.viewModel.viewModelForOrder(in: index, priceDiscount: priceDiscount))
            viewController.delegate = self
    //        vc.presentationController?.delegate = self
            self.present(viewController, animated: true)
        }
    }
}

// MARK: - OrderViewControllerDelegate
extension DetailsViewController: OrderViewControllerDelegate {
    func viewController(supView: OrderViewController, action: OrderViewController.Action) {
        switch action {
        case .addCart:
            loadCartData()
            footerView.isHidden = false
        }
    }
}

// MARK: - CartViewControllerDelegate
extension DetailsViewController: CartViewControllerDelegate {
    func viewController(view: CartViewController, acction: CartViewController.Action) {
        switch acction {
        case.checkOut:
            footerView.isHidden = true
        case .updateCart:
//            quantityCart.text = "\(amout)"
            loadCartData()
            if totalAmout <= 0 {
                footerView.isHidden = true
            }
        case .clearCart:
            footerView.isHidden = true
        }
    }
}

// MARK: - DetailsHeaderViewCellDelegate
extension DetailsViewController: DetailsHeaderViewCellDelegate {
    func viewHeader(view: DetailsHeaderViewCell, action: DetailsHeaderViewCell.Action) {
        let viewController = SeeAllMenuDeltailsViewController(viewModel: viewModel.viewForAllRecommended())
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension DetailsViewController: DetailsTableViewCellDelegate {
    func viewCell(view: DetailsTableViewCell, action: DetailsTableViewCell.Action) {
        let viewController = MapViewController(viewModel: self.viewModel.viewModelForMap())
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
//extension DetailsViewController: UIAdaptivePresentationControllerDelegate {
//    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
//        print("AAAAAAA")
//        return true
//    }
//}
