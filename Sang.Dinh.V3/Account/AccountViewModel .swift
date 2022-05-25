//
//  AccountViewModel .swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 04/05/2022.
//

import Foundation

protocol AccountViewModelType {
    func numberOfSections() -> Int
    func numberOfItem(in section: Int) -> Int
}

enum AccountType: Int, CaseIterable {
    case cell1 = 0
    case cell2
    case cell3
    case logout
}

class AccountViewModel {
}

extension AccountViewModel: AccountViewModelType {
    func numberOfSections() -> Int {
        return AccountType.allCases.count
    }

    func numberOfItem(in section: Int) -> Int {
        guard let section = AccountType(rawValue: section) else {
            return 0
        }
        switch section {
        case .cell1:
            return 1
        case .cell2:
            return 1
        case .cell3:
            return 1
        case .logout:
            return 1
        }
    }
}
