//
//  NamingConventionConverterTests.swift
//  RimuruCoreTests
//
//  Created by funzin on 2020/07/05.
//  Copyright © 2020 funzin. All rights reserved.
//

import XCTest

@testable import RimuruCore
class NamingConventionConverterTests: XCTestCase {
    var converter: NamingConventionConverter!

    override func setUp() {
        super.setUp()
        converter = NamingConventionConverter.shared
    }

    func test_convert() throws {

        struct Input {
            let text: String
            let fromNamingConvention: NamingConvention
            let toNamingConvention: NamingConvention
        }

        typealias Output = String

        func createTestCases() -> [TestCase<Input, Output>] {
            // TestData.allCases(6 patterns) x TestData.allCases(6 patterns)
            let testCases = TestData.allCases
                .map { from in
                    return TestData.allCases.map { to in
                        return TestCase(input: Input(text: from.text,
                                                     fromNamingConvention: from.namingConvention,
                                                     toNamingConvention: to.namingConvention),
                                        output: to.text)
                    }
                }
                .joined()

            return Array(testCases)
        }

        for testCase in createTestCases() {
            let result = try converter.convert(text: testCase.input.text,
                                               from: testCase.input.fromNamingConvention,
                                               to: testCase.input.toNamingConvention)
            XCTAssertEqual(result, testCase.output)
        }
    }

    func test_convert_when_not_contain_capital_letter() {

        XCTAssertThrowsError(try converter.convert(text: "exampletestcase", from: .lower, to: .upper)) { (error) in
            XCTAssertEqual(error as? InputTextError, InputTextError.notContainCapitalLetter)
        }
    }

    func test_convert_when_not_found_separator() {

        XCTAssertThrowsError(try converter.convert(text: "exampleTestCase", from: .snake, to: .lower)) { (error) in
            XCTAssertEqual(error as? InputTextError, InputTextError.notFoundSeparator)
        }

        XCTAssertThrowsError(try converter.convert(text: "exampleTestCase", from: .screamingSnake, to: .lower)) { (error) in
            XCTAssertEqual(error as? InputTextError, InputTextError.notFoundSeparator)
        }

        XCTAssertThrowsError(try converter.convert(text: "exampleTestCase", from: .kebab, to: .lower)) { (error) in
            XCTAssertEqual(error as? InputTextError, InputTextError.notFoundSeparator)
        }

        XCTAssertThrowsError(try converter.convert(text: "exampleTestCase", from: .train, to: .lower)) { (error) in
            XCTAssertEqual(error as? InputTextError, InputTextError.notFoundSeparator)
        }
    }
}

extension NamingConventionConverterTests {
    struct TestData {
        let text: String
        let namingConvention: NamingConvention
    }
}

extension NamingConventionConverterTests.TestData: CaseIterable {
    typealias TestData = NamingConventionConverterTests.TestData

    static let upper          = TestData(text: "ExampleTestCase", namingConvention: .upper)
    static let lower          = TestData(text: "exampleTestCase", namingConvention: .lower)
    static let screamingSnake = TestData(text: "EXAMPLE_TEST_CASE", namingConvention: .screamingSnake)
    static let snake          = TestData(text: "example_test_case", namingConvention: .snake)
    static let kebab          = TestData(text: "example-test-case", namingConvention: .kebab)
    static let train          = TestData(text: "Example-Test-Case", namingConvention: .train)

    static var allCases: [TestData] = [.upper,
                                       .lower,
                                       .screamingSnake,
                                       .snake,
                                       .kebab,
                                       .train]
}
