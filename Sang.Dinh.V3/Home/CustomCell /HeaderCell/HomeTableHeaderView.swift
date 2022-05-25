//
//  HomeTableHeaderView.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 29/04/2022.
//

import UIKit

protocol HomeTableHeaderViewDelegate: AnyObject {
    func cell(_ view: HomeTableHeaderView, _ action: HomeTableHeaderView.Action)
}

class HomeTableHeaderView: UITableViewHeaderFooterView {

    enum Action {
        case seeAll(isSeeAll: Bool)
    }

    var seeAll: Bool = false

    weak var delegate: HomeTableHeaderViewDelegate?

    @IBOutlet weak var nameHeader: UILabel!
    @IBOutlet weak var contentHeader: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(name: String, content: String, tag: Int) {
        nameHeader.text = name
        nameHeader.font = UIFont.boldSystemFont(ofSize: 16)
        contentHeader.text = content
        self.tag = tag
    }
    @IBAction func buttonSeeAll(_ sender: Any) {
        delegate?.cell(self, .seeAll(isSeeAll: seeAll))
    }
}
