//
//  CartTableViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 12/05/2022.
//

import UIKit
protocol CartTableViewCellDelegate: AnyObject {
    func viewCell(cell: CartTableViewCell, action: CartTableViewCell.Action)
}

class CartTableViewCell: UITableViewCell {

    enum Action {
        case minius
        case plus

    }

    @IBOutlet weak var viewConten: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!

    weak var delegate: CartTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configView() {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "Your Text")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                         value: 2,
                                         range: NSRange(location: 0, length: attributeString.length))
        priceLabel.attributedText = attributeString
        viewConten.layer.cornerRadius = 10
        viewConten.layer.shadowColor = UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 0.06).cgColor
        viewConten.layer.shadowOpacity = 1
        viewConten.layer.shadowRadius = 4
        viewConten.layer.shadowOffset = CGSize(width: 0, height: 1)
        viewConten.layer.bounds = viewConten.bounds
        viewConten.layer.position = viewConten.center
    }

    @IBAction func miniusButton(_ sender: Any) {
        delegate?.viewCell(cell: self, action: .minius)
    }
    @IBAction func plusButton(_ sender: Any) {
        delegate?.viewCell(cell: self, action: .plus)
    }
    func setData(name: String, note: String, price: Int, quantity: Int, discount: Int) {
        nameLabel.text = name
        noteLabel.text = note
        priceLabel.text = "\(price) $"
        quantityLabel.text = "\(quantity)"
        discountLabel.text = "\(discount)$"
    }
}
