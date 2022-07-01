//
//  OnboardingViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 28/06/2022.
//

import Foundation
import UIKit

protocol OnboardingViewModelTyple {
    func getData(in index: IndexPath) -> Onboarding
    func numberOfItemsInSection() -> Int
    func dataForItems(at index: IndexPath) -> OnboardingCollectionCellData
}

final class OnboardingViewModel {

    var onboarding: [Onboarding] = []

    init(onboarding: [Onboarding] = []) {
        self.onboarding = [Onboarding(
            img: UIImage(named: "Tracking & Maps"),
            title: "Nearby restaurants",
            content: "You don't have to go far to find a good restaurant, we have provided all the restaurants that is near you"),
                                        Onboarding(
            img: UIImage(named: "Order"),
            title: "Select the Favorites Menu",
            content: "Now eat well, don't leave the house,You can choose your favorite food only with one click"),
                                        Onboarding(
            img: UIImage(named: "Safe Food"),
            title: "Good food at a cheap price",
            content: "You can eat at expensive restaurants with affordable price"),
        ]
    }
}

extension OnboardingViewModel: OnboardingViewModelTyple {
    func dataForItems(at index: IndexPath) -> OnboardingCollectionCellData {
        let item = onboarding[index.item]
        return OnboardingCollectionCellData(
            image: item.img,
            title: item.title,
            content: item.content)
    }

    func numberOfItemsInSection() -> Int {
        onboarding.count
    }

    func getData(in index: IndexPath) -> Onboarding {
        self.onboarding[index.item]
    }
}

struct Onboarding {
    let img: UIImage?
    let title: String
    let content: String
}
