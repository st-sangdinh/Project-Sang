//
//  DetailHistoryViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 11/05/2022.
//

import UIKit

class DetailHistoryViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var viewTotal: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!

    var viewModel: DetailHistoryViewModelType

    init(viewModel: DetailHistoryViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configTabelView()
        totalPriceLabel.text = "Total: \(viewModel.totalDiscount())$"
    }

    func configView() {
        headerLabel.font = UIFont.boldSystemFont(ofSize: 17)
        headerLabel.text = viewModel.getResName()
        let date = viewModel.getDataTime()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd - HH:mm a"
        dateLabel.text = dateFormatter.string(from: date!)
        dateLabel.font = UIFont.boldSystemFont(ofSize: 14)
        viewTotal.layer.cornerRadius = 10
    }

    func configTabelView() {
        tabelView.register(UINib(nibName: "DetailHistoryTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "DetailHistoryTableViewCell")
        tabelView.dataSource = self
        totalPriceLabel.layer.cornerRadius = 10

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
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension DetailHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "DetailHistoryTableViewCell", for: indexPath) as? DetailHistoryTableViewCell
        let checkMenu = viewModel.getItemOrder(at: indexPath)
//        let price = checkMenu.menuItem.price
//        let discount = checkMenu.menuItem.discount
//        let priceDiscount = CGFloat(price) * (CGFloat(CGFloat(100 - discount) / 100))
        let priceDiscount = viewModel.priceDiscount(at: indexPath)
        cell?.setData(
            name: checkMenu.menuItem.name ,
            price: priceDiscount,
            note: checkMenu.notes,
            quantity: checkMenu.amout )

        return cell ?? UITableViewCell()
    }
}
