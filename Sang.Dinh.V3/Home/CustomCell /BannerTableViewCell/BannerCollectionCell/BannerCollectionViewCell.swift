//
//  BannerCollectionViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 28/04/2022.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.cornerRadius = 20
    }

    func updateImage(img: String) {
        imageView.downloaded(from: img)
    }
}
