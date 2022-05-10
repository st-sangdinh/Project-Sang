//
//  BannerTableViewCellModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 28/04/2022.
//

import Foundation
import UIKit

protocol BannerTableCellViewModelType {
    func numberOfItem() -> Int
    
    func bannerImage(at indexPath: IndexPath) -> UIImage?
}


class BannerTableCellViewModel {
    var bannerImages: [UIImage?] = []
    
    init(bannerImages: [UIImage?] = []) {
        self.bannerImages = bannerImages
    }
}

extension BannerTableCellViewModel: BannerTableCellViewModelType {
    func numberOfItem() -> Int {
        return bannerImages.count
    }
    
    func bannerImage(at indexPath: IndexPath) -> UIImage? {
        let bannerImage = bannerImages[indexPath.row]
        return bannerImage
    }
}
