//
//  RecommendedCollectionViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 20/05/2022.
//

import UIKit

class RecommendedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
    }

    func configView() {
        viewContent.layer.cornerRadius = 15
        imgView.layer.cornerRadius = 15
        imgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
    }

    func setData(img: String, name: String, price: Int) {
        imgView.downloaded(from: img)
        nameLabel.text = name
        priceLabel.text = "\(price) $"
    }

}
