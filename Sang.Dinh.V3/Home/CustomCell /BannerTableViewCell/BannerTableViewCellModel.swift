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
    func banner(at index: Int) -> String
//    func bannerImage(at indexPath: IndexPath) -> UIImage?
}

class BannerTableCellViewModel {
    var bannerImages: [ListBanners] = []

    init(bannerImages: [ListBanners] = []) {
        self.bannerImages = bannerImages
    }
}

extension BannerTableCellViewModel: BannerTableCellViewModelType {
    func banner(at index: Int) -> String {
        bannerImages[index].imageUrl
    }

    func numberOfItem() -> Int {
        return bannerImages.count
    }

//    func bannerImage(at indexPath: IndexPath) -> UIImage? {
//        let bannerImage = bannerImages[indexPath.row]
//        return bannerImage
//    }
}
