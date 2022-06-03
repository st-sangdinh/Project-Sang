//
//  BookingTableViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 29/04/2022.
//

import UIKit
protocol BookingTableViewCellDelegate: AnyObject {
    func viewCell(view: BookingTableViewCell, action: BookingTableViewCell.Action)
}

class BookingTableViewCell: UITableViewCell {

    enum Action {
        case detail
    }

    var viewModel: BookingTableViewModelType = BookingTableViewModel()
    weak var delegate: BookingTableViewCellDelegate?

    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var imgBooking: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configView() {
        imgBooking.layer.cornerRadius = 8
        contenView.layer.cornerRadius = 10
        contenView.layer.cornerRadius = 16
        contenView.layer.borderWidth = 0.0
        contenView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        contenView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contenView.layer.shadowRadius = 1
        contenView.layer.shadowOpacity = 8
        contenView.layer.masksToBounds = false
    }

    @IBAction func booking(_ sender: Any) {
        delegate?.viewCell(view: self, action: .detail)
    }

    func setData(img: String, name: String, address: String) {
        nameLabel.text = name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        imgBooking.downloaded(from: img)
        addressLabel.text = address
    }
}
