//
//  SuffixTests.swift
//  SuffixTests
//
//  Created by 李露 on 2024/7/6.
//

import XCTest
@testable import FoodPicker

final class SuffixTests: XCTestCase {
    
    var sut: Suffix<MyWeightUnit>!
    
    // 测试方法命名
    // test_主体_情况_结果
    
    func testJoinNumberAndSuffix() throws {
        // test_formattedString_suffixIsEmpty_shouldNotIncludeSpace
        // sut = .init(wrappedValue: 100, "")
        // XCTAssertEqual(sut.projectedValue, "100", "没有单位时不应该有空格后缀")

        sut = .init(wrappedValue: 100.1, .gram)
        XCTAssertEqual(sut.projectedValue.description, "100.1 g")
    }
    
    
    func testNumberFormatter() throws {
        sut = .init(wrappedValue: 100, .gram)
        XCTAssertEqual(sut.projectedValue.description, "100 g", "你把后缀包装器玩坏了？？")
        
        sut = .init(wrappedValue: 100.678, .gram)
        XCTAssertEqual(sut.projectedValue.description, "100.7 g", "应该要在小数点第一位四舍五入")
        
        sut = .init(wrappedValue: -100.678, .gram)
        XCTAssertEqual(sut.projectedValue.description, "-100.7 g")
        
        sut = .init(wrappedValue: 100.6111, .gram)
        XCTAssertEqual(sut.projectedValue.description, "100.6 g")
    }
    
}
