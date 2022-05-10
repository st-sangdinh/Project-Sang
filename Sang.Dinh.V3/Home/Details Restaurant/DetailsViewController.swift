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
        navigationView.layer.cornerRadius = 20
        navigationView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reloadData()
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
    
    func reloadData(){
        tableView.reloadData()
    }
    
  
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
//        vc.delegate = self
//        vc.presentationController?.delegate = self
        self.present(vc, animated: true)
    }
}


//extension DetailsViewController: OrderViewControllerDelegate {
//    func cell(supView: OrderViewController, action: OrderViewController.Action) {
//        <#code#>
//    }
//}

//extension DetailsViewController: UIAdaptivePresentationControllerDelegate {
//    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
//        print("AAAAAAA")
//        return true
//    }
//}
