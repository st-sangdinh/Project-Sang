//
//  HomeViewControllerModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 28/04/2022.
//

import Foundation
import UIKit


protocol HomeViewModelType {
    
    func numberOfSection() -> Int
    
    func numberOfItem(in section: Int) -> Int
    
    func getListMenu(in indexPath: IndexPath) -> Restaurant
    
    func viewModelForBannerTabbleViewCell(in indexPath: IndexPath) -> BannerTableCellViewModel
    
    func viewModelForTodayTabbleViewCell(in indexPath: IndexPath) -> TodayTableViewModel
    
    func viewModelForBookingTabbleViewCell(in indexPath: IndexPath) -> BookingTableViewModel
    
    func viewModelForSeeAllViewController() -> SeeALLViewModel
    
    func viewMdelForDetailsView(in indexPath: IndexPath) -> DetailsViewModel
    
    func getAIP(completion: @escaping () -> Void)
}



enum HomeType: Int, CaseIterable {
    case banner = 0
    case today
    case booking
}

class HomeViewModel {
    var bannerImages: [UIImage?] = []
    var listMenus: [Restaurant] = []
    var listPhoto: [String] = []
    
    init(){
        bannerImages = [UIImage(named: "blog-1"),UIImage(named: "blog-2"),UIImage(named: "blog-3")]
    }
    
}

extension HomeViewModel: HomeViewModelType {
    func getListMenu(in indexPath: IndexPath) -> Restaurant {
        listMenus[indexPath.row]
    }
    
    func viewModelForBookingTabbleViewCell(in indexPath: IndexPath) -> BookingTableViewModel {
        return BookingTableViewModel(listToday: listMenus)
    }
    
    func viewModelForSeeAllViewController() -> SeeALLViewModel {
        return SeeALLViewModel(listToday: listMenus)
    }
    
    func viewMdelForDetailsView(in indexPath: IndexPath) -> DetailsViewModel {
        return DetailsViewModel(listDetails: listMenus[indexPath.item])
    }
    
    
    func viewModelForTodayTabbleViewCell(in indexPath: IndexPath) -> TodayTableViewModel {
        return TodayTableViewModel(listToday: listMenus)
    }
    
    func numberOfSection() -> Int {
        return HomeType.allCases.count
    }
    
    func numberOfItem(in section: Int) -> Int {
        guard let section = HomeType(rawValue: section) else {
            return 0
        }
        switch section {
        case .banner:
            return 1
        case .today:
            return 1
        case .booking:
            // TODO
            return listMenus.count
        }
    }
    
    func viewModelForBannerTabbleViewCell(in indexPath: IndexPath) -> BannerTableCellViewModel {
        return BannerTableCellViewModel(bannerImages: bannerImages)
    }
    
    func getAIP(completion: @escaping () -> Void){
        guard let url = URL(string: "https://ios-interns.herokuapp.com/api/restaurants") else {
            return
        }
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: url) { data, _, _ in
            if let data = data {
                let json = data.converToJson(from: data)
                if let datas = json["data"] as? [[String: Any]]{
                    for item in datas {
                        let id = item["id"] as? Int ?? 0
                        let name = item["name"] as? String ?? ""
                        let address = item["address"] as? [String:Any]
                        let lat = address?["lat"] as? Double ?? 0
                        let lng = address?["lng"] as? Double ?? 0
                        let ar = address?["address"] as? String ?? ""
                        let photos = item["photos"] as? [String] ?? []
                        var menus: [Menu] = []
                        if let menu = item["menus"] as? [[String: Any]] {
                            for i in menu {
                                let id = i["id"] as? Int ?? 0
                                let type = i["type"] as? Int ?? 0
                                let name = i["name"] as? String ?? ""
                                let description = i["description"] as? String ?? ""
                                let price = i["price"] as? Int ?? 0
                                let imageUrl = i["imageUrl"] as? String ?? ""
                                let discount = i["discount"] as? Int ?? 0
                                let menu = Menu(id: id, type: type, name: name, description: description, price: price, imageUrl: imageUrl, number: 0, discount: discount)
                                menus.append(menu)
                            }
                        }
            
                        let list = Restaurant(id: id , name: name , address: Address(lat: lat , lng: lng , address: ar), photos: photos, menu: menus)
                        
                        self.listMenus.append(list)
                    }
                }
            }
            DispatchQueue.main.async {
                completion()
            }
        }
        task.resume()
    }
}

extension Data {
    func converToJson(from jsonData: Data) -> [String: Any] {
        var json: [String: Any] = [:]
        do {
            if let jsonObj = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String: Any] {
                json = jsonObj
            }
        }catch {
            print("Json error")
        }
        
        return json
    }
}
