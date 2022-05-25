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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationHome()
        configTableView()
        getAPI()
        getAPIBanners()
    }

    func getAPI() {
        // Show loading
        loaderView.startAnimating()
        viewModel.getAIP {
            self.loaderView.stopAnimating()
            self.viewLoad.isHidden = true
            self.tableView.reloadData()
        }
    }

    func getAPIBanners() {
        loaderView.startAnimating()
        viewModel.getAPIBenners {
            self.loaderView.stopAnimating()
            self.viewLoad.isHidden = true
            self.tableView.reloadData()
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
//    func refreshControl () {
//        let refreshControl = UIRefreshControl()
//
//        refreshControl.tintColor = UIColor.green
//                refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
//                tableView.addSubview(refreshControl)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
//                     self.refreshControl.endRefreshing()
//                     self.tableView.contentOffset = .zero
//                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                         self.tableView.scrollToTop(animated: true)
//                     }
//                 })
//    }
//    @objc private func refreshData() {
//        trendingVC.reloadData()
//        loadData()
//    }
//

    @objc func listButton() {
        print("dsds")
    }

    @objc func imgAccButton() {
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
            cell.viewModel = viewModel.viewModelForTodayTabbleViewCell(in: indexPath)
            cell.reloadData()
            cell.didSelect = {
                let viewController = DetailsViewController(
                    viewModel: self.viewModel.viewMdelForDetailsView(in: indexPath))
                viewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            return cell
        case .booking:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "BookingTableViewCell",
                for: indexPath) as? BookingTableViewCell else {
                return UITableViewCell()
            }
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
            return 250
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
                let viewController = SeeAllViewController(viewModel: viewModel.viewModelForSeeAllViewController())
                navigationController?.pushViewController(viewController, animated: true)
            } else {
                let viewController = SeeAllToDayViewController()
                viewController.viewModel = viewModel.viewModelForSeeAllTodayViewController()
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
//    func cell(action: HomeTableHeaderView.Action) {
//        switch action {
//        case .seeAll(let isSeeAll):
//            let se = tableView.numberOfSections
//            guard let section = HomeType(rawValue: se) else {
//                return
//            }
//            switch section {
//            case .today:
//                return print("SeeAll ")
//            case.booking:
//            print(isSeeAll)
//        }
//    }
}
