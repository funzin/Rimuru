//
//  TestCase.swift
//  RimuruCoreTests
//
//  Created by funzin on 2020/07/05.
//  Copyright © 2020 funzin. All rights reserved.
//

import Foundation

struct TestCase<Input, Output> {
    let input: Input
    let output: Output
    let description: String?

    init(input: Input, output: Output, description: String? = nil) {
        self.input = input
        self.output = output
        self.description = description
    }
}
