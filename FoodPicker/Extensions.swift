//
//  Extensions.swift
//  FoodPicker
//
//  Created by 李露 on 2024/6/19.
//

import SwiftUI

extension View {
    /// 主按钮风格
    /// - Returns: View
    func mainButtonStyle() -> some View {
        buttonStyle(.borderedProminent)
        // self.buttonStyle(.borderedProminent)，不建议self.这种写法
        .buttonBorderShape(.capsule)
        .controlSize(.large)
    }
    
    /// 圆角矩形背景
    /// - Parameters:
    ///   - radius: 圆角半径
    ///   - fill: 填充前景元素时使用的颜色或图案
    /// - Returns: 某种视图
    func roundedRectBackground(
        radius: CGFloat = 8,
        fill: some ShapeStyle = .bg
    ) -> some View {
        background(RoundedRectangle(cornerRadius: radius).fill(fill))
    }
}

extension Animation {
    static let fpSpring = Animation.spring(dampingFraction: 0.55)
    static let fpEaseInOut = Animation.easeInOut(duration: 0.6)
}

extension ShapeStyle where Self == Color {
    static var bg: Color { Color(.systemBackground) }
    static var bg2: Color { Color(.secondarySystemBackground) }
}

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
