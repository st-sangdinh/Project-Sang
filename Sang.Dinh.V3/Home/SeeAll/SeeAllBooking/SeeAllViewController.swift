//
//  SeeAllViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 09/05/2022.
//

import UIKit

class SeeAllViewController: UIViewController {

    var viewModel: SeeALLViewModelType

    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!

    init(viewModel: SeeALLViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    func configView() {
        navigationView.layer.cornerRadius = 20
        navigationView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
    }

    func configTableView() {
        tableView.register(
            UINib(nibName: "BookingTableViewCell",
                  bundle: nil), forCellReuseIdentifier: "BookingTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension SeeAllViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getListMenu().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "BookingTableViewCell",
            for: indexPath) as? BookingTableViewCell
        let menu = viewModel.getMenu(at: indexPath)
        cell?.setData(
            img: menu.photos.first ?? "" ,
            name: menu.name,
            address: menu.address.address)
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension SeeAllViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailsViewController(viewModel: self.viewModel.viewMdelForDetailsView(in: indexPath))
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
