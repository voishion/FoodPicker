//
//  FoodListScreen.swift
//  FoodPicker
//
//  Created by 李露 on 2024/6/19.
//

import SwiftUI

struct FoodListScreen: View {
    @Environment(\.editMode) var editMode
    @State private var food = Food.examples
    @State private var selectedFoodId = Set<Food.ID>()
    @State private var sheet: Sheet?
    
    private var isEditing: Bool { editMode?.wrappedValue == .active }
    
    var body: some View {
        VStack (alignment: .leading) {
            titleBar
            
            List($food, editActions: .all, selection: $selectedFoodId, rowContent: buildFoodRaw)
                .listStyle(.plain)
                .padding(.horizontal)
        }
        .background(.groupBg)
        .safeAreaInset(edge: .bottom, content: buildFloatButton)
        .sheet(item: $sheet)
    }
}

// MARK: Subviews
private extension FoodListScreen {
    var titleBar: some View {
        HStack {
            Label("食物清单", systemImage: .forkAndKnife)
                .font(.title.bold())
                .foregroundColor(.accentColor)
                .push(to: .leading)
            
            EditButton()
                .buttonStyle(.bordered)
                .environment(\.locale, .init(identifier: "zh-CN"))
        }.padding()
    }
    
    var addButton: some View {
        Button {
            sheet = .newFood { food.append($0) }
        } label: {
            SFSymbol.plus
                .font(.system(size: 50))
                .padding()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, Color.accentColor.gradient)
        }
    }
    
    var removeButton: some View {
        Button {
            withAnimation {
                food = food.filter{ !selectedFoodId.contains($0.id) }
            }
        } label: {
            Text("删除已选项")
                .font(.title2.bold())
                .maxWidth()
        }.mainButtonStyle(shape: .roundedRectangle(radius: 8)).padding(.horizontal, 50)
    }
    
    func buildFloatButton() -> some View {
        ZStack {
            removeButton
                .transition(.move(edge: .leading).combined(with: .opacity).animation(.easeInOut))
                .opacity(isEditing ? 1 : 0)
                .id(isEditing)
            addButton
                .scaleEffect(isEditing ? 0.00001 : 1)
                .opacity(isEditing ? 0 : 1)
                .animation(.easeInOut, value: isEditing)
                .push(to: .trailing)
        }
    }
    
    func buildFoodRaw(foodBinding: Binding<Food>) -> some View {
        let food = foodBinding.wrappedValue
        return HStack {
            Text(food.name)
                .font(.title3)
                .padding(.vertical, 8)
                .push(to: .leading)
                .contentShape(Rectangle()) // 填充形状，让其可以点击
                .onTapGesture {
                    if isEditing { 
                        selectedFoodId.insert(food.id)
                        return
                    }
                    sheet = .foodDetail(food)
                }
            if isEditing {
                SFSymbol.pencil
                    .font(.title2.bold())
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        sheet = .editFood(foodBinding)
                    }
            }
        }
    }
}

// MARK: Preview
#Preview {
    // 将环境变量editMode设置为active
    //FoodListView().environment(\.editMode, .constant(.active))
    FoodListScreen()
        //.environment(\.dynamicTypeSize, .accessibility1) // 开启辅助模式
}
