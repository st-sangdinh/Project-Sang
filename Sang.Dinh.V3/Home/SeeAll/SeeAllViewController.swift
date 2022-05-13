//
//  SeeAllViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 09/05/2022.
//

import UIKit

class SeeAllViewController: UIViewController {

    var viewModel: SeeALLViewModelType

    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: SeeALLViewModelType){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "seeAll"
        configTableView()
    }
    
    func configTableView() {
        tableView.register(UINib(nibName: "BookingTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }


}

extension SeeAllViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getListMenu().first?.menu.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTableViewCell", for: indexPath) as? BookingTableViewCell
        
        let menu = viewModel.getMenu(at: indexPath).menu[indexPath.row]
        
        cell?.setData(img: menu.imageUrl , name: menu.name, address: "\(menu.price) $")
        return cell ?? UITableViewCell()
    }
}

extension SeeAllViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController(viewModel: self.viewModel.viewMdelForDetailsView(in: indexPath))
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
