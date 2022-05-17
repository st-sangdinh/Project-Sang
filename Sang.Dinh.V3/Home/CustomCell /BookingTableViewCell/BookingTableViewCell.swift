//
//  BookingTableViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 29/04/2022.
//

import UIKit

class BookingTableViewCell: UITableViewCell {

    var viewModel: BookingTableViewModelType = BookingTableViewModel()
    
    
    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var imgBooking: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
            
        // Configure the view for the selected state
    }
    
    
    
    @IBAction func booking(_ sender: Any) {
        print("Book")
    }
    
    func setData(img: String, name: String, address: String) {
        nameLabel.text = name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        imgBooking.downloaded(from: img)
        addressLabel.text = address
    }
}
