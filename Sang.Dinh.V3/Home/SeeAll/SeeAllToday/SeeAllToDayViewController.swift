//
//  SeeAllToDayViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 23/05/2022.
//

import UIKit

class SeeAllToDayViewController: UIViewController {

    var viewModel: SeeAllTodayViewModelType = SeeAllTodayViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configCollectionView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    func configView() {
        navigationView.layer.cornerRadius = 20
        navigationView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
    }

    func configCollectionView() {
        collectionView.register(
            UINib(nibName: "TodayCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "TodayCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension SeeAllToDayViewController: UICollectionViewDataSource {

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
extension SeeAllToDayViewController: UICollectionViewDelegateFlowLayout {
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
        return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = DetailsViewController(viewModel: self.viewModel.viewMdelForDetailsView(in: indexPath))
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
