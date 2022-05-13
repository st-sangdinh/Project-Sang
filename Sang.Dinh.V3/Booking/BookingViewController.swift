//
//  BookingViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 27/04/2022.
//

import UIKit

class BookingViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        headerView.layer.cornerRadius = 20
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        configTableView()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func configTableView(){
        tableView.register(UINib(nibName: "BookingHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingHistoryTableViewCell")
        tableView.dataSource = self
    }
    
}
extension BookingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        StoreOrderData.histories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingHistoryTableViewCell", for: indexPath) as? BookingHistoryTableViewCell
        let menuHistory = StoreOrderData.histories[indexPath.row]
        cell?.setData(img: menuHistory.img, name: menuHistory.nameStore, address: menuHistory.address)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}

extension BookingViewController:  BookingHistoryTableViewCellDelegate {
    func bookingTable(subView: BookingHistoryTableViewCell) {
        guard let indexPath = tableView.indexPath(for: subView) else { return }
        let vm = BookingViewModel().makeVC(indexPath: indexPath)
        let vc = DetailHistoryViewController(viewModel: vm)

        vc.hidesBottomBarWhenPushed = true
        navigationController?.present(vc, animated: true)
    }
}

