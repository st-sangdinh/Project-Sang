//
//  BookingHistoryTableViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 04/05/2022.
//

import UIKit

protocol BookingHistoryTableViewCellDelegate: AnyObject {
    func bookingTable(subView: BookingHistoryTableViewCell)
}

class BookingHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    weak var delegate: BookingHistoryTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.layer.cornerRadius = 8
        checkButton.layer.cornerRadius = 10
        selectionStyle = .none
        contenView.layer.cornerRadius = 16
        contenView.layer.borderWidth = 0.0
        contenView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        contenView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contenView.layer.shadowRadius = 1
        contenView.layer.shadowOpacity = 8
        contenView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(img: String, name: String, address: String) {
        nameLable.text = name
        imgView.downloaded(from: img)
        addressLabel.text = address
    }
    
    @IBAction func buttonCheck(_ sender: Any) {
        delegate?.bookingTable(subView: self)
    }
}
