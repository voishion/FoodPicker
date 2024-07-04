//
//  SFSymbol.swift
//  FoodPicker
//
//  Created by 李露 on 2024/7/4.
//

import SwiftUI

enum SFSymbol: String {
    case pencil
    case plus = "plus.circle.fill"
    case chevronUp = "chevron.up"
    case chevronDown = "chevron.down"
    case xmark = "xmark.circle.fill"
    case forkAndKnife = "fork.knife"
    case info = "info.circle.fill"
}

extension SFSymbol: View {
    var body: Image {
        Image(systemName: rawValue)
    }
    
    func resizable() -> Image {
        self.body.resizable()
    }
}

extension Label where Title == Text, Icon == Image {
    init(_ text: String, systemImage: SFSymbol) {
        self.init(text, systemImage: systemImage.rawValue)
    }
}
