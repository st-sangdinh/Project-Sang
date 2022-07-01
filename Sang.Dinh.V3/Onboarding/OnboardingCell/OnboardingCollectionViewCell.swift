//
//  OnboardingCollectionViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 28/06/2022.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(data: OnboardingCollectionCellData) {
        img.image = data.image
        titleLabel.text = data.title
        contentLabel.text = data.content
    }
}

struct OnboardingCollectionCellData {
    let image: UIImage?
    let title: String
    let content: String
}

