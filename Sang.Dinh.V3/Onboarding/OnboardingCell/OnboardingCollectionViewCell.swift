//
//  OnboardingCollectionViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 28/06/2022.
//

import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!

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

