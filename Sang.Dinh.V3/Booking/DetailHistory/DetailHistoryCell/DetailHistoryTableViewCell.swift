//
//  DetailHistoryTableViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 11/05/2022.
//

import UIKit

class DetailHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configTabelView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configTabelView() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)

        contenView.layer.cornerRadius = 10
        contenView.layer.shadowColor = UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 0.06).cgColor
        contenView.layer.shadowOpacity = 1
        contenView.layer.shadowRadius = 4
        contenView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contenView.layer.bounds = contenView.bounds
        contenView.layer.position = contenView.center
    }

    func setData(name: String, price: Int, note: String, quantity: Int) {
        nameLabel.text = name
        priceLabel.text = "\(price) $"
        noteLabel.text = note
        quantityLabel.text = "x\(quantity)"
    }
}
