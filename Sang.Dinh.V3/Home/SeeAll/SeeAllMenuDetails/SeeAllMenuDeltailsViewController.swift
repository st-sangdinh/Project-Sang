//
//  SeeAllMenuDeltailsViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 20/05/2022.
//

import UIKit

class SeeAllMenuDeltailsViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var viewCheckOut: UIView!
    @IBOutlet weak var labelCheckOut: UILabel!
    @IBOutlet weak var quantityCart: UILabel!

    var viewModel: SeeAllMenuDeltailsViewModelType

    init(viewModel: SeeAllMenuDeltailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        configView()
        loadCartData()

        if CartDataStore.shared.getCart().isEmpty {
            footerView.isHidden = true
        } else {
            loadCartData()
            footerView.isHidden = false
        }
        // Do any additional setup after loading the view.
    }

    func configView() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        contentView.layer.cornerRadius = 20
        contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        footerView.layer.cornerRadius = 20
        footerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        footerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.09).cgColor
        footerView.layer.shadowOpacity = 1
        footerView.layer.shadowRadius = 14
        footerView.layer.shadowOffset = CGSize(width: 0, height: -1)
        footerView.layer.bounds = footerView.bounds
        footerView.layer.position = footerView.center

        cartView.layer.cornerRadius = 10
        cartView.layer.shadowColor = UIColor(red: 0.055, green: 0.498, blue: 0.239, alpha: 0.24).cgColor
        cartView.layer.shadowOpacity = 1
        cartView.layer.shadowRadius = 5
        cartView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cartView.layer.bounds = cartView.bounds
        cartView.layer.position = cartView.center

        viewCheckOut.layer.cornerRadius = 10
        viewCheckOut.layer.shadowColor = UIColor(red: 0.055, green: 0.498, blue: 0.239, alpha: 0.24).cgColor
        viewCheckOut.layer.shadowOpacity = 1
        viewCheckOut.layer.shadowRadius = 5
        viewCheckOut.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewCheckOut.layer.bounds = viewCheckOut.bounds
        viewCheckOut.layer.position = viewCheckOut.center
    }

    func configCollectionView() {
        collectionView.register(
            UINib(nibName: "RecommendedCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "RecommendedCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.isNavigationBarHidden = false
//    }
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func loadCartData() {
        let loadCart = viewModel.loadCart()
        labelCheckOut.text = "Check Out \(loadCart.0 ) $"
        quantityCart.text = "\(loadCart.1 ) "
    }

    @IBAction func checkOut(_ sender: Any) {
        let viewController = CartViewController(viewModel: (viewModel.viewModelForCart()))
        viewController.delegate = self
        navigationController?.present(viewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension SeeAllMenuDeltailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "RecommendedCollectionViewCell",
            for: indexPath) as? RecommendedCollectionViewCell

        cell?.layer.borderWidth = 0.0
        cell?.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        cell?.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell?.layer.shadowRadius = 1
        cell?.layer.shadowOpacity = 8
        cell?.layer.masksToBounds = false

        let menu = viewModel.getMenu(at: indexPath)
        cell?.setData(img: menu.imageUrl, name: menu.name, price: menu.price)
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = OrderViewController(viewModel: (viewModel.viewModelForOrder(in: indexPath)))
        viewController.delegate = self
        self.present(viewController, animated: true)
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension SeeAllMenuDeltailsViewController: UICollectionViewDelegateFlowLayout {
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
}

// MARK: - OrderViewControllerDelegate
extension SeeAllMenuDeltailsViewController: OrderViewControllerDelegate {
    func viewController(supView: OrderViewController, action: OrderViewController.Action) {
        switch action {
        case .addCart:
            loadCartData()
            footerView.isHidden = false
        }
    }
}

// MARK: - CartViewControllerDelegate
extension SeeAllMenuDeltailsViewController: CartViewControllerDelegate {
    func viewController(view: CartViewController, acction: CartViewController.Action) {
        switch acction {
        case.checkOut:
            footerView.isHidden = true
        case .updateCart:
//            quantityCart.text = "\(amout)"
            loadCartData()
            if viewModel.loadCart().1 <= 0 {
                footerView.isHidden = true
            }
        case .clearCart:
            footerView.isHidden = true
        }
    }
}
