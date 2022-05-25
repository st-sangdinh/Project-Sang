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

    var viewModel: DetailHistoryViewModel

    var totalDiscount: Int = 0

    init(viewModel: DetailHistoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTabelView()
        headerLabel.text = viewModel.resName
        let date = viewModel.dateTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd - HH:mm a"

        dateLabel.text = dateFormatter.string(from: date!)
        dateLabel.font = UIFont.boldSystemFont(ofSize: 14)
        viewTotal.layer.cornerRadius = 10
        viewModel.resMenu?.forEach({ item in
            let amout = item.amout
            let price = item.menuItem.price
            let discount = item.menuItem.discount
            let priceDiscount = Int(CGFloat(price) * (CGFloat(CGFloat(100 - discount) / 100)))
            totalDiscount += priceDiscount * amout
        })
        totalPriceLabel.text = "Total: \(totalDiscount)$"
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
    @IBAction func buttonTotal(_ sender: Any) {
    }
}

// MARK: - UITableViewDataSource
extension DetailHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.resMenu?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "DetailHistoryTableViewCell", for: indexPath) as? DetailHistoryTableViewCell
        let checkMenu = viewModel.resMenu?[indexPath.row]
        let price = checkMenu?.menuItem.price ?? 0
        let discount = checkMenu?.menuItem.discount ?? 0
        let priceDiscount = CGFloat(price) * (CGFloat(CGFloat(100 - discount) / 100))
        cell?.setData(
            name: checkMenu?.menuItem.name ?? "",
            price: Int(priceDiscount), note: checkMenu?.notes ?? "",
            quantity: checkMenu?.amout ?? 0)

        return cell ?? UITableViewCell()
    }
}
