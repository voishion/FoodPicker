//
//  AnyLayout+.swift
//  FoodPicker
//
//  Created by 李露 on 2024/7/4.
//

import SwiftUI

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
