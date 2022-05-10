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
    @IBOutlet weak var addressLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.cornerRadius = 16
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.roundCorner(corners: [.topLeft,.topRight], radius: 10)
    
    }
    
    func setData(avatar: String, name: String, address: String) {
        img.downloaded(from: avatar)
        nameLabel.text = name
        addressLabel.text = address
    }

}
extension UIView {
    public func roundCorner(corners: UIRectCorner, radius: CGFloat) {
      let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
      let mask = CAShapeLayer()
      mask.path = path.cgPath
      layer.mask = mask
    }
}


