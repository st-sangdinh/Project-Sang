//
//  AccountViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 27/04/2022.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let viewModel: AccountViewModelType = AccountViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true

        configTableView()
        // Do any additional setup after loading the view.
    }

    func configTableView() {
        tableView.register(UINib(nibName: "Cell1TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "Cell1TableViewCell")
        tableView.register(UINib(nibName: "Cell2TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "Cell2TableViewCell")
        tableView.register(UINib(nibName: "Cell3TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "Cell3TableViewCell")
        tableView.register(UINib(nibName: "LogoutTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "LogoutTableViewCell")
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension AccountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItem(in: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let section = AccountType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .cell1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1TableViewCell", for: indexPath)
            return cell
        case .cell2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2TableViewCell", for: indexPath)
            return cell
        case .cell3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3TableViewCell", for: indexPath)
            return cell
        case .logout:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogoutTableViewCell", for: indexPath)
            return cell
        }
    }
}
