//
//  Cell1TableViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 04/05/2022.
//

import UIKit

class Cell1TableViewCell: UITableViewCell {


    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var bellView: UIView!
    @IBOutlet weak var notifyView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewContent.layer.cornerRadius = 11
        
        viewContent.layer.cornerRadius = 16
        viewContent.layer.borderWidth = 0.0
        viewContent.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        viewContent.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewContent.layer.shadowRadius = 6
        viewContent.layer.shadowOpacity = 1
        viewContent.layer.masksToBounds = false
        
        
        
        
        avaImg.layer.cornerRadius = avaImg.bounds.height / 2
        
        bellView.layer.cornerRadius = bellView.bounds.height / 2
        
        notifyView.layer.cornerRadius = notifyView.bounds.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
