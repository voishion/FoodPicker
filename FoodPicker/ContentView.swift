//
//  ContentView.swift
//  FoodPicker
//
//  Created by 李露 on 2024/6/16.
//

import SwiftUI

struct ContentView: View {
    let food = ["汉堡", "沙拉", "披萨", "意大利面", "鸡腿便当", "刀削面", "火锅", "牛肉面", "关东煮"]
    
    @State private var selectedFood: String?
    
    var body: some View {
        VStack (spacing: 30) {
            Image("dinner")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
            
            Text("今天吃什么？")
                .bold()
            
            if selectedFood != .none {
                Text(selectedFood ?? "")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)
                    .id(selectedFood) // 解决旧版没有动画的问题，要的就是转场的效果，因为ID发生了改变
                    // 设定转场效果
//                    .transition(.scale.combined(with: .slide))
                    // 分别设定进场、离场的动画效果
                    .transition(.asymmetric(
                        insertion: .opacity
                            .animation(.easeInOut(duration: 0.5).delay(0.2)),
                        removal: .opacity
                            .animation(.easeInOut(duration: 0.4))))
            }
            
            Button(role: .none) {
                selectedFood = food.shuffled().first {$0 != selectedFood}
            } label: {
                Text(selectedFood == .none ? "请告诉我" : "再换一个").frame(width: 200)
                    .animation(.none, value: selectedFood) // 不想要动画
                    .transformEffect(.identity)            // 不想要位置发生变动（不想转场）
            }.padding(.bottom, -15)
            
            Button(role: .none) {
                selectedFood = .none
            } label: {
                Text("重置").frame(width: 200)
            }.buttonStyle(.bordered)
        }
        .padding()
        // 占用最大高度为无限大
        .frame(maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .font(.title)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        // 选择食物发生变化时，产生动画
        .animation(.easeInOut(duration: 0.6), value: selectedFood)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
