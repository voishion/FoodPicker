//
//  ShapeStyleView使用示例
//
//  ShapeStyleView.swift
//  FoodPicker
//
//  Created by 李露 on 2024/6/19.
//

import SwiftUI

struct ShapeStyleView: View {
    var body: some View {
        ScrollView (showsIndicators: false) {
            // VStack只能放入10个子View
            VStack {
                ZStack {
                    Circle().fill(.yellow)
                    
                    Circle().fill(.image(.init("dinner"), scale: 0.2)).zIndex(1)
                    
                    Text("Hello")
                        .font(.system(size: 100).bold())
                        .foregroundStyle(.linearGradient(
                            colors: [.pink, .indigo],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                        .background {
                            Color.bg2
                                .scaleEffect(x: 1.5, y: 1.3)
                                .blur(radius: 20)
                        }
                }
                
                Circle().fill(.yellow).overlay {
                    Text("Hello")
                        .font(.system(size: 100).bold())
                        .foregroundStyle(.linearGradient(
                            colors: [.pink, .indigo],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                }
                
                Circle().fill(.teal)
                
                Circle().fill(.teal.gradient)
                
                Circle().fill(.image(.init("dinner"), scale: 0.2))
                
                Circle().fill(.linearGradient(
                    colors: [.pink, .indigo],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
                
                Text("Hello")
                    .font(.system(size: 100).bold())
                    .foregroundStyle(.linearGradient(
                        colors: [.pink, .indigo],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing))
            }
        }
    }
}

#Preview {
    ShapeStyleView()
}
