//
//  View+.swift
//  FoodPicker
//
//  Created by 李露 on 2024/7/4.
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

