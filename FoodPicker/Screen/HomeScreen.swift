//
//  HomeScreen.swift
//  FoodPicker
//
//  Created by 李露 on 2024/7/4.
//

import SwiftUI

extension HomeScreen {
    enum Tab: String, View, CaseIterable {
        case picker, list, settings
        
        var body: some View {
            content.tabItem { tabLabel.labelStyle(.iconOnly) }
        }
        
        @ViewBuilder
        private var content: some View {
            switch self {
                case .picker: FoodPickerScreen()
                case .list: FoodListScreen()
                case .settings: SettingsScreen()
            }
        }
        
        private var tabLabel: some View {
            switch self {
                case .picker:
                    return Label("Home", systemImage: .house)
                case .list:
                    return Label("List", systemImage: .list)
                case .settings:
                    return Label("Settings", systemImage: .gear)
            }
        }
    }
}

struct HomeScreen: View {
    @AppStorage(.shouldUseDarkMode) var shouldUseDarkMode = false
    @State var tab: Tab = {
        let rawValue = UserDefaults.standard.string(forKey: UserDefaults.Key.startTab.rawValue) ?? ""
        return Tab(rawValue: rawValue) ?? .picker
    }()
    
    var body: some View {
        NavigationStack {
            TabView(selection: $tab) {
                ForEach(Tab.allCases, id: \.self) { $0 }
            }.preferredColorScheme(shouldUseDarkMode ? .dark : .light)
        }
    }
}

#Preview {
    HomeScreen()
}
