//
//  DetailsTableViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 06/05/2022.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    var viewModel: DetailsTableViewModelType! {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.cornerRadius = 30
        selectionStyle = .none
        configCollection()
    }

    func configCollection() {
        collectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.layer.cornerRadius = 10
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(name: String, address: String) {
        nameLabel.text = name
        addressLable.text = address
    }
    
}

extension DetailsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getListMenu().photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as? DetailsCollectionViewCell
        let image = viewModel.getListMenu().photos[indexPath.item]
        cell?.setData(image: image)
        return cell ?? UICollectionViewCell()
    }
    
}


extension DetailsTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        return CGSize(width: width , height: 182)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        11
    }
    
}
