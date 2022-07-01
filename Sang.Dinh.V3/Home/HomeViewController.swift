//
//  HomeViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 27/04/2022.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loaderView: Loader!
    @IBOutlet weak var viewLoad: UIView!

    let viewModel: HomeViewModelType = HomeViewModel()
    var contactsData: [String] = []
    var contacts: [String] = []
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationHome()
        configTableView()
        refreshHome()
//        getAPI()
        getAPIBanners()
        getRestaurant()
    }
//
//    func getAPI() {
//        // Show loading
//        loaderView.startAnimating()
//        let completion: () -> Void = {
//            self.loaderView.stopAnimating()
//            self.viewLoad.isHidden = true
//            self.tableView.reloadData()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
//                self.refreshControl.endRefreshing()
//                self.tableView.contentOffset = .zero
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                        self.tableView.scrollsToTop = true
//                    }
//                })
//        }
//        viewModel.getAIP(completion: completion)
//    }

    func getRestaurant() {
        loaderView.startAnimating()
        viewModel.getRestaurant { [weak self] result in
            guard let this = self else { return }
            this.loaderView.stopAnimating()
            switch result {
            case .success:
                    this.viewLoad.isHidden = true
                    this.tableView.reloadData()
            case .failure(let error):
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel)
                    let alertViewController = UIAlertController(title: "Error",
                                                                message: error.localizedDescription,
                                                                preferredStyle: .alert)
                    alertViewController.addAction(cancelAction)
                    this.present(alertViewController, animated: true)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                this.refreshControl.endRefreshing()
                this.tableView.contentOffset = .zero
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        this.tableView.scrollsToTop = true
                    }
                })
        }
    }

    func getAPIBanners() {
        loaderView.startAnimating()
        viewModel.getAPIBenners { [weak self] result in
            guard let this = self else { return }
            this.loaderView.stopAnimating()
            switch result {
            case .success:
                this.viewLoad.isHidden = true
                this.tableView.reloadData()
            case .failure(let error):
                let cancelAction = UIAlertAction(title: "OK", style: .cancel)
                let alertViewController = UIAlertController(title: "Error",
                                                            message: error.localizedDescription,
                                                            preferredStyle: .alert)
                alertViewController.addAction(cancelAction)
                this.present(alertViewController, animated: true)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                this.refreshControl.endRefreshing()
                this.tableView.contentOffset = .zero
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    this.tableView.scrollsToTop = true
                }
            })
        }
    }

    func configTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: "BannerTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "BannerTableViewCell")
        tableView.register(UINib(nibName: "TodayTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "TodayTableViewCell")
        tableView.register(UINib(nibName: "BookingTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "BookingTableViewCell")
        tableView.register(UINib(nibName: "HomeTableHeaderView", bundle: nil),
                           forHeaderFooterViewReuseIdentifier: "HomeTableHeaderView")

        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionFooterHeight = .leastNonzeroMagnitude

    }

    func refreshHome() {
        refreshControl.tintColor = .green
                refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
                tableView.addSubview(refreshControl)
    }

    @objc func refreshData() {
//        getAPI()
        getRestaurant()
        getAPIBanners()
    }

    func navigationHome() {
        let listButton = UIBarButtonItem(image: UIImage(named: "List"),
                                         style: .done,
                                         target: self,
                                         action: #selector(listButton))
        listButton.tintColor = .black
        let image2 = UIBarButtonItem(image: UIImage(named: "Ellipse 4")?.withRenderingMode(.alwaysOriginal),
                                     style: .plain,
                                     target: self,
                                     action: #selector(imgAccButton))

        let titleContainer = UIView()
            titleContainer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 45)

            let searchIcon = UIButton()

            searchIcon.setImage(UIImage(named: "place"), for: .normal)
//            searchIcon.backgroundColor = UIColor.red
            searchIcon.layer.frame = CGRect(x: 55, y: 8, width: 28, height: 28)

            titleContainer.addSubview(searchIcon)

            let titleLabel = UILabel()
            titleLabel.frame = CGRect(x: 75, y: 8, width: 146, height: 28)
            titleLabel.textColor = UIColor.black
            titleLabel.font = UIFont.systemFont(ofSize: 12)

            titleContainer.addSubview(titleLabel)

            let button = UIButton(frame: CGRect(x: 30, y: 8, width: 174, height: 28))
            button.backgroundColor = .clear
            titleContainer.addSubview(button)
            titleLabel.text = "Agrabad 435, Chittagong"

            self.navigationItem.titleView = titleContainer

            navigationItem.rightBarButtonItem = image2
            navigationItem.leftBarButtonItem = listButton

    }

    @objc func listButton() {
        print("dsds")
    }

    @objc func imgAccButton() {
//        let a = AccountViewController()
    }
    @IBAction func searchButton(_ sender: Any) {
        let viewController = SearchViewController()

        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItem(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HomeType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .banner:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "BannerTableViewCell", for: indexPath) as? BannerTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForBannerTabbleViewCell(in: indexPath)
            return cell
        case .today:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "TodayTableViewCell", for: indexPath) as? TodayTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForTodayTabbleViewCell()
            cell.reloadData()
            cell.delegate = self
            return cell
        case .booking:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "BookingTableViewCell",
                for: indexPath) as? BookingTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            let menu = viewModel.getListMenu(in: indexPath)
            cell.setData(
                img: menu.photos.first ?? "",
                name: menu.name ,
                address: menu.address.address )
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = HomeType(rawValue: section) else {
            return UIView()
        }
        switch section {
        case .banner:
            return nil
        case .today:
            let headerView = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: "HomeTableHeaderView") as? HomeTableHeaderView
            headerView?.setData(name: "Today New Arivable", content: "Best of the today  food list update", tag: 0)
            headerView?.delegate = self
            return headerView ?? UIView()
        case.booking:
            let headerView = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: "HomeTableHeaderView") as? HomeTableHeaderView
            headerView?.setData(name: "Booking Restaurant", content: "Check your city Near by Restaurant", tag: 1)
            headerView?.delegate = self
            return headerView ?? UIView()
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = HomeType(rawValue: indexPath.section) else {
            return CGFloat()
        }
        switch section {
        case .banner:
            return 200
        case .today:
            return 230
        case .booking:
            return 93
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = HomeType(rawValue: section) else {
            return CGFloat()
        }
        switch section {
        case.banner:
            return .leastNonzeroMagnitude
        case.today:
            return 50
        case.booking:
            return 50
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let viewController = DetailsViewController(viewModel: self.viewModel.viewMdelForDetailsView(in: indexPath))
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: HomeTableHeaderViewDelegate
extension HomeViewController: HomeTableHeaderViewDelegate {
    func cell(_ view: HomeTableHeaderView, _ action: HomeTableHeaderView.Action) {
        switch action {
        case .seeAll:
            if view.tag == 1 {
                let viewController = SeeAllViewController()
                viewController.viewModel = viewModel.viewModelForSeeAllViewController()
                navigationController?.pushViewController(viewController, animated: true)
            } else {
                let viewController = SeeAllToDayViewController()
                viewController.viewModel = viewModel.viewModelForSeeAllTodayViewController()
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}

// MARK: - TodayTableViewCellDelegate
extension HomeViewController: TodayTableViewCellDelegate {
    func viewCell(view: TodayTableViewCell, action: TodayTableViewCell.Action) {
        switch action {
        case .didSelect:
            guard let indexPath = tableView.indexPath(for: view) else {return}
            let viewController = DetailsViewController(
                viewModel: self.viewModel.viewMdelForDetailsView(in: indexPath))
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - BookingTableViewCellDelegate
extension HomeViewController: BookingTableViewCellDelegate {
    func viewCell(view: BookingTableViewCell, action: BookingTableViewCell.Action) {
        switch action {
        case.detail:
            guard let indexPath = tableView.indexPath(for: view) else {return}
            let viewController = DetailsViewController(viewModel: viewModel.viewMdelForDetailsView(in: indexPath))
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
