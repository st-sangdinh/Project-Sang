//
//  DetailsTableView.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 06/05/2022.
//

import UIKit

protocol DetailsHeaderViewCellDelegate: AnyObject {
    func viewHeader(view: DetailsHeaderViewCell, action: DetailsHeaderViewCell.Action)
}

class DetailsHeaderViewCell: UITableViewHeaderFooterView {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nameLabel: UILabel!

    weak var delegate: DetailsHeaderViewCellDelegate?

    enum Action {
        case seeAll
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        view.roundCorner(corners: [.topLeft, .topRight], radius: 16)
    }
    @IBAction func seeAll(_ sender: Any) {
        delegate?.viewHeader(view: self, action: .seeAll)
    }
}
