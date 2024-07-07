//
//  UserDefaultsKey.swift
//  FoodPicker
//
//  Created by 李露 on 2024/7/6.
//

import SwiftUI

extension UserDefaults {
    enum Key: String {
        case shouldUseDarkMode
        case startTab
        case foodList
        case preferredEnergyUnit
        case preferredWieghtUnit
    }
}
