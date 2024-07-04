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
    func mainButtonStyle(shape: ButtonBorderShape = .capsule) -> some View {
        buttonStyle(.borderedProminent)
        // self.buttonStyle(.borderedProminent)，不建议self.这种写法
        .buttonBorderShape(shape)
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
    
    func sheet(item: Binding<(some View & Identifiable)?>) -> some View {
        sheet(item: item) { $0 }
    }
    
    
    /// - Tag: push
    func push(to alignment: TextAlignment) -> some View {
        switch alignment {
            case .leading:
                return frame(maxWidth: .infinity, alignment: .leading)
            case .center:
                return frame(maxWidth: .infinity, alignment: .center)
            case .trailing:
                return frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    /// Shortut: [push(to: .center)](x-source-tag://push)
    func maxWidth() -> some View {
        push(to: .center)
    }
    
    func readGeometry<Key: PreferenceKey, Value>(_ keyPath: KeyPath<GeometryProxy, Value>, key: Key.Type) -> some View where Key.Value == Value {
        overlay {
            GeometryReader{ proxy in
                Color.clear.preference(key: key, value: proxy[keyPath: keyPath])
            }
        }
    }
}

extension Animation {
    static let fpSpring = Animation.spring(dampingFraction: 0.55)
    static let fpEaseInOut = Animation.easeInOut(duration: 0.6)
}

extension ShapeStyle where Self == Color {
    static var bg: Color { Color(.systemBackground) }
    static var bg2: Color { Color(.secondarySystemBackground) }
    static var groupBg: Color { Color(.systemGroupedBackground) }
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

extension AnyLayout {
    /// 根据条件判断返回水平或垂直的Layout
    /// - Parameters:
    ///   - condition: 条件
    ///   - spacing: 间距
    ///   - content: 内容
    /// - Returns: Layout
    static func useVStack(if condition: Bool, spacing: CGFloat, @ViewBuilder content: @escaping () -> some View) -> some View {
        let layout = condition ? AnyLayout(VStackLayout(spacing: spacing)) : AnyLayout(HStackLayout(spacing: spacing))
        
        return layout(content)
    }
}
