//
//  DetailsCollectionViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 09/05/2022.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img.layer.cornerRadius = 10
    }
    
    func setData(image: String) {
        img.downloaded(from: image)
    }
}
