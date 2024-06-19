//
//  ContentView.swift
//  FoodPicker
//
//  Created by 李露 on 2024/6/16.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedFood: Food?
    @State private var shouldShowInfo: Bool = false
    
    let food = Food.examples
    
    var body: some View {
        ScrollView (showsIndicators:false) {
            VStack (spacing: 30) {
                foodImage
                
                Text("今天吃什么？").bold()
                
                selectedFoodInfoView
                
                Spacer().layoutPriority(1)
                
                selectFoodButton
                
                resetButton
            }
            .padding()
            // 占用最大高度为无限大
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - 100)
            .font(.title)
            .mainButtonStyle()
            .animation(.fpSpring, value: shouldShowInfo)
            // 选择食物发生变化时，产生动画
            .animation(.fpSpring, value: selectedFood)
        }.background(Color.bg2)
    }
}

// MARK: - Subviews
private extension ContentView {
    var foodImage: some View {
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
    }
    
    var foodNameView: some View {
        HStack {
            Text(selectedFood!.name)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.green)
                // 解决旧版没有动画的问题，要的就是转场的效果，因为ID发生了改变
                .id(selectedFood!.name)
                // 设定转场效果
                // .transition(.scale.combined(with: .slide))
                // 分别设定进场、离场的动画效果
                .transition(.delayInsertionOpacity)
            Button {
                shouldShowInfo.toggle()
            } label: {
                Image(systemName: "info.circle.fill").foregroundColor(.secondary)
            }.buttonStyle(.plain)
        }
    }
    
    var foodDetailView: some View {
        VStack {
            if shouldShowInfo {
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
                        // $属性名=>获取有后缀版本的字符串
                        Text(selectedFood!.$protein)
                        Text(selectedFood!.$fat)
                        Text(selectedFood!.$carb)
                    }
                }
                .font(.title3)
                .padding(.horizontal)
                .padding()
                .roundedRectBackground()
                .transition(.moveUpWithOpacity)
            }
        }
        .frame(maxWidth: .infinity)
        .clipped()
    }
    
    @ViewBuilder var selectedFoodInfoView: some View {
        if selectedFood != .none {
            foodNameView
            
            Text("热量 \(selectedFood!.$calorie)")
                .font(.title2)
            
            foodDetailView
        }
    }
    
    var selectFoodButton: some View {
        Button(role: .none) {
            selectedFood = food.shuffled().first {$0 != selectedFood}
        } label: {
            Text(selectedFood == .none ? "请告诉我" : "再换一个").frame(width: 200)
                .animation(.none, value: selectedFood) // 不想要动画
                .transformEffect(.identity)            // 不想要位置发生变动（不想转场）
        }.padding(.bottom, -15)
    }
    
    var resetButton: some View {
        Button(role: .none) {
            selectedFood = .none
            shouldShowInfo = false
        } label: {
            Text("重置").frame(width: 200)
        }.buttonStyle(.bordered)
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
