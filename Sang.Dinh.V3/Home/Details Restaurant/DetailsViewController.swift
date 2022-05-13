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
        
        if CartData.carts.isEmpty {
            footerView.isHidden = true
        }else {
            loadCartData()
            footerView.isHidden = false
        }
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
                                        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func configTableView() {
        tableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailsTableViewCell")
        tableView.register(UINib(nibName: "ListDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "ListDetailsTableViewCell")
        tableView.register(UINib(nibName: "DetailsTableView", bundle: nil), forHeaderFooterViewReuseIdentifier: "DetailsTableView")
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func configView() {
        footerView.layer.cornerRadius = 20
        footerView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
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
        labelCheckOut.text = "Check Out \(viewModel.price()) $"
        quantityCart.text = "\(viewModel.quantity()) "

    }
    
    func reloadData(){
        tableView.reloadData()
    }
    
  
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func checkOut(_ sender: Any) {
        let vc = CartViewController(viewModel: viewModel.viewModelForCart())
        vc.delegate = self
        navigationController?.present(vc, animated: true)
    }
}


extension DetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return viewModel.getListMenu().menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as? DetailsTableViewCell
            
            let menu = viewModel.getListMenu()
            
            cell?.setData(name: menu.name, address: menu.address.address)
            cell?.viewModel = viewModel.viewModelForDetails(in: indexPath)
            
            return cell ?? UITableViewCell()
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListDetailsTableViewCell", for: indexPath) as? ListDetailsTableViewCell
            
            let menu = viewModel.getMenu(at: indexPath)
            
            cell?.setData(image: menu.imageUrl, name: menu.name, description: menu.description)
            
            cell?.delegate = self
            
            return cell ?? UITableViewCell()
        }
    
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DetailsTableView")
            return headerView
        }
        return UIView()
    }
}

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 75
        }
        return .leastNormalMagnitude
    }
}

extension DetailsViewController: ListDetailsTableViewCellDelegate {
    func cell(subView: ListDetailsTableViewCell) {
        guard let indexPath = tableView.indexPath(for: subView) else { return  }
        let vc = OrderViewController(viewModel: self.viewModel.viewModelForOrder(in: indexPath))
        vc.delegate = self
//        vc.presentationController?.delegate = self
        self.present(vc, animated: true)
    }
}


extension DetailsViewController: OrderViewControllerDelegate {
    func viewController(supView: OrderViewController, action: OrderViewController.Action) {
        switch action {
        case .addCart:
            loadCartData()
            footerView.isHidden = false
        }
    }
}
    
extension DetailsViewController: CartViewControllerDelegate {
    func viewController(view: CartViewController, acction: CartViewController.Action) {
        switch acction {
        case.checkOut:
            footerView.isHidden = true
        case .updateCart(let amout):
            quantityCart.text = "\(amout)"
        }
    }
}


//extension DetailsViewController: UIAdaptivePresentationControllerDelegate {
//    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
//        print("AAAAAAA")
//        return true
//    }
//}
