//
//  AnyTransition+.swift
//  FoodPicker
//
//  Created by 李露 on 2024/7/4.
//

import SwiftUI

extension AnyTransition {
    /// 向上移动不透明度
    static let moveUpWithOpacity = Self.move(edge: .top).combined(with: .opacity)
    
    /// 进场、离场的动画，两个都是透明度的变化，进场会延迟0.2秒
    static let delayInsertionOpacity = Self.asymmetric(
        insertion: .opacity
            .animation(.easeInOut(duration: 0.5).delay(0.2)),
        removal: .opacity
            .animation(.easeInOut(duration: 0.4)))
}
