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
    
    let viewModel: HomeViewModelType = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        navigationHome()
        configTableView()
        
        viewModel.getAIP {
            self.tableView.reloadData()
        }
    }
    
    func configTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: "BannerTableViewCell", bundle: nil), forCellReuseIdentifier: "BannerTableViewCell")
        
        tableView.register(UINib(nibName: "TodayTableViewCell", bundle: nil), forCellReuseIdentifier: "TodayTableViewCell")
        
        tableView.register(UINib(nibName: "BookingTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingTableViewCell")
        
            
        tableView.register(UINib(nibName: "HomeTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HomeTableHeaderView")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionFooterHeight = .leastNonzeroMagnitude
    }
    
    func navigationHome() {
        let listButton = UIBarButtonItem(image: UIImage(named: "List"),style: .done, target: self, action: #selector(listButton))
        listButton.tintColor = .black
        let image2 = UIBarButtonItem(image: UIImage(named: "thor")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(imgAccButton))

        let titleContainer = UIView()
            titleContainer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 45)

            let searchIcon = UIButton()

            searchIcon.setImage(UIImage(named: "place"), for: .normal)
//            searchIcon.backgroundColor = UIColor.red
            searchIcon.layer.frame = CGRect(x: 30, y: 8, width: 28, height: 28)
        
            titleContainer.addSubview(searchIcon)
            
            

            let titleLabel = UILabel()
            titleLabel.frame = CGRect(x: 50, y: 8, width: 146, height: 28)
            titleLabel.textColor = UIColor.black//(red:255, green:255, blue:255, alpha:1.0)
            titleLabel.font = UIFont.systemFont(ofSize: 12)
            
            titleContainer.addSubview(titleLabel)
        
            let button = UIButton(frame: CGRect(x: 30, y: 8, width: 174, height: 28))
            button.backgroundColor = .clear
//            button.addTarget(self, action: #selector(buttonTouch), for: .touchUpInside)
            titleContainer.addSubview(button)
            titleLabel.text = "Agrabad 435, Chittagong"

            self.navigationItem.titleView = titleContainer
            
            
            
            navigationItem.rightBarButtonItem = image2
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
//        button.setImage(UIImage(named: "thor"), for: .normal)
//        button.backgroundColor = .red
//        let imgAccButton = UIBarButtonItem(customView: button)
//        navigationItem.rightBarButtonItem = imgAccButton
        navigationItem.leftBarButtonItem = listButton
        
    }

    
    @objc func listButton() {
        print("dsds")
    }
    
    @objc func imgAccButton() {
        
    }
//    @objc func buttonTouch() {
//        navigationController?.pushViewController(MapViewController(), animated: true)
//    }

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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath) as? BannerTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForBannerTabbleViewCell(in: indexPath)
            return cell
        case .today:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodayTableViewCell", for: indexPath) as? TodayTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForTodayTabbleViewCell(in: indexPath)
            cell.reloadData()
            cell.didSelect = { index in
                let vc = DetailsViewController(viewModel: self.viewModel.viewMdelForDetailsView(in: index))
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case .booking:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTableViewCell", for: indexPath) as? BookingTableViewCell else {
                return UITableViewCell()
            }
            let menu = viewModel.getListMenu(in: indexPath)
            cell.setData(img: menu.photos.first ?? "", name: menu.name , address: menu.address.address )
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
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeTableHeaderView") as? HomeTableHeaderView
            headerView?.setData(name: "Today New Arivable", content: "Best of the today  food list update", tag: 0)
            headerView?.delegate = self
            return headerView ?? UIView()
        case.booking:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeTableHeaderView") as? HomeTableHeaderView
            headerView?.setData(name: "Booking Restaurant", content: "Check your city Near by Restaurant", tag: 1)
            headerView?.delegate = self
            return headerView ?? UIView()
        }
    }
}

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

            let vc = DetailsViewController(viewModel: self.viewModel.viewMdelForDetailsView(in: indexPath))
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension HomeViewController: HomeTableHeaderViewDelegate {
    func cell(_ view: HomeTableHeaderView, _ action: HomeTableHeaderView.Action) {
        switch action {
        case .seeAll(_):
            if view.tag == 0 {
                let vc = SeeAllViewController(viewModel: viewModel.viewModelForSeeAllViewController())
                navigationController?.pushViewController(vc, animated: true)
            } else {
                print("SeeAll booking")
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
