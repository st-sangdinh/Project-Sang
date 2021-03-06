//
//  TodayTableViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 28/04/2022.
//

import UIKit
protocol TodayTableViewCellDelegate: AnyObject {
    func viewCell(view: TodayTableViewCell, action: TodayTableViewCell.Action)
}

class TodayTableViewCell: UITableViewCell {

    enum Action {
        case didSelect
    }

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: TodayTableViewModelType = TodayTableViewModel() {
        didSet {
            reloadData()
        }
    }

    weak var delegate: TodayTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configTableViewCell()
    }

    func reloadData() {
        collectionView.reloadData()
    }

    func configTableViewCell() {
        collectionView.register(UINib(nibName: "TodayCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "TodayCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension TodayTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "TodayCollectionViewCell", for: indexPath) as? TodayCollectionViewCell
              cell?.layer.cornerRadius = 16
              cell?.layer.borderWidth = 0.0
              cell?.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
              cell?.layer.shadowOffset = CGSize(width: 0, height: 2)
              cell?.layer.shadowRadius = 1
              cell?.layer.shadowOpacity = 8
              cell?.layer.masksToBounds = false
        let menu = viewModel.getMenu(at: indexPath).menus[indexPath.item]
        cell?.setData(avatar: menu.imageUrl, name: menu.name, price: menu.price)
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TodayTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 148, height: 196)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        didSelect?()
        delegate?.viewCell(view: self, action: .didSelect)
    }
}
