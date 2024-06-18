//
//  ContentView.swift
//  FoodPicker
//
//  Created by 李露 on 2024/6/16.
//

import SwiftUI

struct ContentView: View {
    let food = Food.examples
    
    @State private var selectedFood: Food?
    
    var body: some View {
        ScrollView {
            VStack (spacing: 30) {
                Group {
                    if selectedFood != .none {
                        Text(selectedFood!.image)
                            .font(.system(size: 200))
                            .minimumScaleFactor(0.7)
                            .lineLimit(1)
                    } else {
                        Image("dinner")
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
                    }
                }.frame(height: 250)
                
                Text("今天吃什么？")
                    .bold()
                
                if selectedFood != .none {
                    HStack {
                        Text(selectedFood!.name)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.green)
                            .id(selectedFood!.name) // 解决旧版没有动画的问题，要的就是转场的效果，因为ID发生了改变
                        // 设定转场效果
                        //                    .transition(.scale.combined(with: .slide))
                        // 分别设定进场、离场的动画效果
                            .transition(.asymmetric(
                                insertion: .opacity
                                    .animation(.easeInOut(duration: 0.5).delay(0.2)),
                                removal: .opacity
                                    .animation(.easeInOut(duration: 0.4))))
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
                
                Text("热量 \(selectedFood!.calorie.formatted()) 大卡")
                    .font(.title2)
                
                // HStack排版
                /*
                HStack {
                    VStack (spacing: 12) {
                        Text("蛋白质")
                        Text(selectedFood!.protein.formatted() + "g")
                    }
                    
                    Divider().frame(width: 1).padding(.horizontal)
                    
                    VStack (spacing: 12) {
                        Text("脂肪")
                        Text(selectedFood!.fat.formatted() + "g")
                    }
                    
                    Divider().frame(width: 1).padding(.horizontal)
                    
                    VStack (spacing: 12) {
                        Text("碳水")
                        Text(selectedFood!.carb.formatted() + "g")
                    }
                }
                .font(.title3)
                .padding(.horizontal)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color(.systemBackground))
                )
                */
                
                // Grid排版
                Grid (horizontalSpacing: 16, verticalSpacing: 12) {
                    GridRow {
                        Text("蛋白质")
                        Text("脂肪")
                        Text("碳水")
                    }.frame(minWidth: 70)
                    
                    // 水平分割线
                    Divider()
                        .gridCellUnsizedAxes(.horizontal)
                        .padding(.horizontal, -10)
                    
                    GridRow {
                        Text(selectedFood!.protein.formatted() + "g")
                        Text(selectedFood!.fat.formatted() + "g")
                        Text(selectedFood!.carb.formatted() + "g")
                    }
                }
                .font(.title3)
                .padding(.horizontal)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color(.systemBackground))
                )
                
                
                Spacer().layoutPriority(1) 
                
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
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - 100)
            .font(.title)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            // 选择食物发生变化时，产生动画
            .animation(.easeInOut(duration: 0.6), value: selectedFood)
        }.background(Color(.secondarySystemBackground))
    }
}

extension ContentView {
    init(selectedFood: Food) {
        _selectedFood = State(wrappedValue: selectedFood)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedFood: .examples.first!)
//        ContentView(selectedFood: .examples.first!)
//        ContentView(selectedFood: .examples.first!).previewDevice(.iPhoneSE)
    }
}
