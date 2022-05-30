//
//  BookingViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 27/04/2022.
//

import UIKit

class BookingViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        configView()
        configTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func configView() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        headerView.layer.cornerRadius = 20
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    func configTableView() {
        tableView.register(UINib(nibName: "BookingHistoryTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "BookingHistoryTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.isEditing = true
    }
}

// MARK: - UITableViewDataSource
extension BookingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        StoreDataOrder.shared.getHistoryOrder().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "BookingHistoryTableViewCell", for: indexPath) as? BookingHistoryTableViewCell
//        let menuHistory = StoreOrderData.histories[indexPath.row]
        let menuHistory = StoreDataOrder.shared.getHistoryOrder(at: indexPath.row)
        cell?.setData(img: menuHistory.img, name: menuHistory.nameStore, address: menuHistory.address)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension BookingViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            print("deleting row")
            let menuHistory = StoreDataOrder.shared.getHistoryOrder(at: indexPath.row)
            StoreDataOrder.shared.removeHistoryOrder(item: menuHistory, at: indexPath.row)
            tableView.reloadData()
        default:
            return
        }
    }
}

// MARK: - BookingHistoryTableViewCellDelegate
extension BookingViewController: BookingHistoryTableViewCellDelegate {
    func bookingTable(subView: BookingHistoryTableViewCell) {
        guard let indexPath = tableView.indexPath(for: subView) else { return }
        let viewModel = BookingViewModel().makeVC(indexPath: indexPath)
        let viewController = DetailHistoryViewController(viewModel: viewModel)

        viewController.hidesBottomBarWhenPushed = true
        navigationController?.present(viewController, animated: true)
    }
}
