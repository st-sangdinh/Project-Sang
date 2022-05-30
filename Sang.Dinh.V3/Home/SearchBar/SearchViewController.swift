//
//  SearchViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 24/05/2022.
//

import UIKit

class SearchViewController: UIViewController {
    var viewModel: SearchBarViewModelType = SearchBarViewModel()

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loaderView: Loader!

    var filterRestaurant: [Restaurant]  = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configView()
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
        viewContent.layer.cornerRadius = 20
        viewContent.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        searchBar.layer.cornerRadius = 12
        searchBar.delegate = self
    }

    func configTableView() {
        tableView.register(UINib(nibName: "BookingTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "BookingTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getFilterRestaurant().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "BookingTableViewCell", for: indexPath) as? BookingTableViewCell
        let res = viewModel.getFilterRestaurant()[indexPath.row]
        cell?.setData(img: res.photos.first ?? "", name: res.name, address: res.address.address)
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailsViewController(viewModel: viewModel.viewMdelForDetailsView(in: indexPath))
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loaderView.startAnimating()
        viewModel.getAIP {_ in
            self.loaderView.stopAnimating()
            DispatchQueue.main.async {
                self.viewModel.setKeyWord(keyWord: searchBar.text ?? "")
                self.tableView.reloadData()
            }
        }
        view.endEditing(true)
    }
}
