//
//  DetailsTableViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 06/05/2022.
//

import UIKit

protocol DetailsTableViewCellDelegate: AnyObject {
    func viewCell(view: DetailsTableViewCell, action: DetailsTableViewCell.Action)
}

class DetailsTableViewCell: UITableViewCell {

    enum Action {
        case didSelect
    }

    var viewModel: DetailsTableViewModelType! {
        didSet {
            collectionView.reloadData()
        }
    }

    weak var delegate: DetailsTableViewCellDelegate?

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLable: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.cornerRadius = 30
        selectionStyle = .none
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        timeLabel.font =  UIFont.boldSystemFont(ofSize: 12)
        configCollection()
    }

    func configCollection() {
        collectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func locationButton(_ sender: Any) {
        delegate?.viewCell(view: self, action: .didSelect)
    }

    func setData(name: String, address: String) {
        nameLabel.text = name
        addressLable.text = address
    }
}

// MARK: - UICollectionViewDataSource
extension DetailsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as? DetailsCollectionViewCell
        let image = viewModel.getListMenu().photos[indexPath.item]
        cell?.setData(image: image)
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailsTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        return CGSize(width: width, height: 182)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
}
