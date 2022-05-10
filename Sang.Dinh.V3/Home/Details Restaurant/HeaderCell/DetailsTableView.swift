//
//  DetailsTableView.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 06/05/2022.
//

import UIKit

class DetailsTableView: UITableViewHeaderFooterView {

    @IBOutlet weak var view: UIView!

    override func layoutSubviews() {
        super.layoutSubviews()
        view.roundCorner(corners: [.topLeft,.topRight], radius: 16)
    }
}
