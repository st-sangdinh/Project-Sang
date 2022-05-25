//
//  RecommendedTableViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 20/05/2022.
//

import UIKit

protocol RecommendedTableViewCellDelegate: AnyObject {
    func viewCell(view: RecommendedTableViewCell, action: RecommendedTableViewCell.Action)
}

class RecommendedTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: RecommendedTableViewModelType?
//    var didSelect: ((IndexPath) -> Void)?
    weak var delegate: RecommendedTableViewCellDelegate?
    enum Action {
        case item(IndexPath)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configTableView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configTableView() {
        collectionView.register(UINib(nibName: "RecommendedCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "RecommendedCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
// MARK: - UICollectionViewDataSource
extension RecommendedTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let viewModel = viewModel else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "RecommendedCollectionViewCell", for: indexPath) as? RecommendedCollectionViewCell
        let menu = viewModel.getMenu(at: indexPath)
//        cell?.layer.cornerRadius = 16
        cell?.layer.borderWidth = 0.0
        cell?.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        cell?.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell?.layer.shadowRadius = 1
        cell?.layer.shadowOpacity = 8
        cell?.layer.masksToBounds = false
        cell?.setData(img: menu.imageUrl, name: menu.name, price: menu.price)
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RecommendedTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftSpacing = 12
        let width  = (Int(UIScreen.main.bounds.width) - (leftSpacing * 2) - 10) / 2
        return CGSize(width: width, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.viewCell(view: self, action: .item(indexPath))
//        didSelect?(indexPath)
    }
}
