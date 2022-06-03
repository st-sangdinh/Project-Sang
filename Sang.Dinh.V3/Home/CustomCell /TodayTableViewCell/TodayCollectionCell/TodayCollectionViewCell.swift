//
//  TodayCollectionViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 28/04/2022.
//

import UIKit

class TodayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
    }

    func configView() {
        view.layer.cornerRadius = 16
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        img.layer.cornerRadius = 10
        img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    func setData(avatar: String, name: String, price: Int) {
        img.downloaded(from: avatar)
        nameLabel.text = name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        priceLabel.text = ("\(price) $")
    }

}
//extension UIView {
//    public func roundCorner(corners: UIRectCorner, radius: CGFloat) {
//      let path = UIBezierPath(
//        roundedRect: bounds,
//        byRoundingCorners: corners,
//        cornerRadii: CGSize(width: radius, height: radius))
//      let mask = CAShapeLayer()
//      mask.path = path.cgPath
//      layer.mask = mask
//    }
//}
