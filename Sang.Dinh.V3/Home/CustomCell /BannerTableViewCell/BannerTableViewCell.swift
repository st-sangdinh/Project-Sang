//
//  BannerTableViewCell.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 28/04/2022.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var viewModel: BannerTableCellViewModelType? {
        didSet {
            reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configTableViewCell()
    }
    
    func configTableViewCell() {
        collectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func reloadData() {
        pageControl.numberOfPages = viewModel?.numberOfItem() ?? 0
        collectionView.reloadData()
    }

    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
        let item = sender.currentPage
        let indexPath = IndexPath(item: item, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension BannerTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.numberOfItem() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.updateImage(img: viewModel?.bannerImage(at: indexPath))
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BannerTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 280, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        11
    }
    
}

extension BannerTableViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let indexPath = indexPathOfCurrentCell() else {
            return
        }
        pageControl.currentPage = indexPath.row
    }

    private func indexPathOfCurrentCell() -> IndexPath? {
        var visbleOffset = collectionView.contentOffset
        visbleOffset.x += collectionView.center.x
        visbleOffset.y += collectionView.center.y
        collectionView.indexPathForItem(at: visbleOffset)
        guard let indexPath = collectionView.indexPathForItem(at: visbleOffset) else {
                return nil
        }
        return indexPath
    }
}
