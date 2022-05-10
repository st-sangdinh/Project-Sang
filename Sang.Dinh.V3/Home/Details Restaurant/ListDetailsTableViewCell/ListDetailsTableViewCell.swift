//
//  ListDetailsTableViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 06/05/2022.
//

import UIKit


protocol ListDetailsTableViewCellDelegate: AnyObject {
    func cell(subView: ListDetailsTableViewCell)
}

class ListDetailsTableViewCell: UITableViewCell {
    
    enum Action {
        case order
    }
    

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    weak var delegate: ListDetailsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 0.1).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 4
        view.layer.shadowOffset =  CGSize(width: 0, height: 1)
        view.layer.bounds = view.bounds
        view.layer.position = view.center

        img.layer.cornerRadius = 8
        checkButton.layer.cornerRadius = 8
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(image: String, name: String, description: String) {
        img.downloaded(from: image)
        nameLabel.text = name
        descriptionLabel.text = description
    }
    @IBAction func checkButton(_ sender: Any) {
        
        delegate?.cell(subView: self)
        
    }
    
}
