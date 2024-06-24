//
//  FoodForm.swift
//  FoodPicker
//
//  Created by 李露 on 2024/6/23.
//

import SwiftUI

private enum MyField {
    case title, image, calorie, protein, fat, carb
}

extension FoodListView {
    struct FoodForm: View {
        @Environment(\.dismiss) var dismiss
        
        @FocusState private var field: MyField?
        @State var food: Food
        
        private var isNotValid: Bool {
            food.name.isEmpty
            || food.image.isEmpty
            || food.image.count > 2
            //            || food.calorie == .zero
            //            || food.protein.isNaN
            //            || food.fat.isNaN
            //            || food.carb.isNaN
        }
        
        private var invalidMessage: String? {
            if food.name.isEmpty { return "请输入名称" }
            if food.image.isEmpty { return "请输入图片" }
            if food.image.count > 2 { return "图片超过2个字符" }
            return .none
        }
        
        var body: some View {
            NavigationStack {
                VStack {
                    HStack {
                        Label("编辑食物信息", systemImage: "pencil")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                            .foregroundColor(.accentColor)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle.bold())
                            .foregroundColor(.secondary)
                            .onTapGesture {
                                dismiss()
                            }
                    }.padding([.horizontal, .top])
                    
                    Form {
                        LabeledContent("名称") {
                            TextField("必填", text: $food.name)
                                .submitLabel(.next)
                                .focused($field, equals: .title)
                                .onSubmit {
                                    field = .image
                                }
                        }
                        
                        LabeledContent("图片") {
                            TextField("必填，最多输入2个字符", text: $food.image)
                                .submitLabel(.next)
                                .focused($field, equals: .image)
                                .onSubmit {
                                    field = .calorie
                                }
                        }
                        
                        buildNumberField(title: "热量", value: $food.calorie, suffix: "大卡")
                            .submitLabel(.next)
                            .focused($field, equals: .calorie)
                            .onSubmit {
                                field = .protein
                            }
                        
                        buildNumberField(title: "蛋白质", value: $food.protein)
                        
                        buildNumberField(title: "脂肪", value: $food.fat)
                        
                        buildNumberField(title: "碳水", value: $food.carb)
                    }.padding(.top, -16)
                    
                    Button {
                        
                    } label: {
                        Text(invalidMessage ?? "保存").frame(maxWidth: .infinity)
                    }
                    .mainButtonStyle()
                    .padding()
                    .disabled(isNotValid)
                }
                .background(.groupBg)
                .multilineTextAlignment(.trailing)
                .font(.title3)
                .scrollDismissesKeyboard(.interactively)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Text("<")
                        Text(">")
                    }
                }
            }
        }
        
        private func buildNumberField(title: String, value: Binding<Double>, suffix: String = "g") -> some View {
            LabeledContent(title) {
                HStack {
                    TextField("必填", value: value, format:
                            .number.precision(.fractionLength(1))
                    ).keyboardType(.decimalPad)
                    Text(suffix)
                }
            }
        }
    }
}

#Preview {
    FoodListView.FoodForm(food: Food.examples.first!)
}
