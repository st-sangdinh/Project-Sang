//
//  UIImageViewExt.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 05/05/2022.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
        let indivatorView = UIActivityIndicatorView()
        self.addSubview(indivatorView)
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }

    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
