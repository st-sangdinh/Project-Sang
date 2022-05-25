//
//  SearchBarViewModel.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 24/05/2022.
//

import Foundation

protocol SearchBarViewModelType {
    func getAIP(completion: @escaping (Bool) -> Void)
    func setKeyWord(keyWord: String)
    func getFilterRestaurant() -> [Restaurant]
    func viewMdelForDetailsView(in indexPath: IndexPath) -> DetailsViewModel
}

class SearchBarViewModel {
    var filterRestaurant: [Restaurant] = []
    var keyWord: String = ""
}

extension SearchBarViewModel: SearchBarViewModelType {
    func getAIP(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://ios-interns.herokuapp.com/api/restaurants?page=0&limit=20") else {
            return
        }
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: url) {[weak self] data, _, error in
            guard let this = self else {
                return
            }
            if error == nil {
                completion(false)
            }
            if let data = data {
                let decoder = JSONDecoder()
                if let datas = try? decoder.decode(RestaurantResponse.self, from: data) {
//
//                    for item in datas.data {
//
//                        self.restaurant.append(item)
//                    }
                    let restaurant = datas.data
                    restaurant.filter { res in
                        if res.name.contains(this.keyWord) {
                            this.filterRestaurant.append(res)
                        }
                        return true
                    }
//
                    DispatchQueue.main.async {
                        completion(true)
                    }
                }
            }
        }
        task.resume()
    }
    func setKeyWord(keyWord: String) {
        self.keyWord = keyWord
    }
    func getFilterRestaurant() -> [Restaurant] {
        filterRestaurant
    }
    func viewMdelForDetailsView(in indexPath: IndexPath) -> DetailsViewModel {
        return DetailsViewModel(listDetails: filterRestaurant[indexPath.item])
    }
}
