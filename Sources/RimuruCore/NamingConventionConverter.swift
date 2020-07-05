//
//  NamingConventionConverter.swift
//  RimuruCore
//
//  Created by funzin on 2020/07/05.
//  Copyright © 2020 funzin. All rights reserved.
//

import Foundation

public final class NamingConventionConverter {
    public static let shared = NamingConventionConverter()

    public func convert(text: String,
                        from fromNamingConvention: NamingConvention,
                        to toNamingConvention: NamingConvention) throws -> String {
        let textArray = try split(text: text, namingConvention: fromNamingConvention)
        let result = join(textArray: textArray, namingConvention: toNamingConvention)
        return result
    }

    private func splitMeans(namingConvention: NamingConvention) -> SplitMeans {
        switch namingConvention {
        case .upper:
            return .regex(pattern: "[A-Z][^A-Z]+")
        case .lower:
            return .regex(pattern: "([a-z]+|[A-Z][^A-Z]+)")
        case .screamingSnake,
             .snake:
            return .split(separator: "_")
        case .kebab,
             .train:
            return .split(separator: "-")
        }
    }

    private func split(text: String, namingConvention: NamingConvention) throws -> [String] {
        switch splitMeans(namingConvention: namingConvention) {
        case let .regex(pattern):
            guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
                throw InputTextError.notConverted
            }

            let matches = regex.matches(in: text, range: NSRange(location: 0, length: text.count))
            guard !(matches.count == 1) else {
                throw InputTextError.notContainCapitalLetter
            }

            let array: [String] = matches
                .map { match in
                    let range = match.range
                    let start = text.index(text.startIndex, offsetBy: range.location)
                    let end = text.index(start, offsetBy: range.length)
                    return String(text[start..<end])
            }
            return array
        case let .split(separator):
            let array = text.split(separator: separator).map { String($0) }
            guard text != array.first else {
                throw InputTextError.notFoundSeparator
            }
            return array
        }
    }

    private func join(textArray: [String], namingConvention: NamingConvention) -> String {
        switch namingConvention {
        case .upper:
            return textArray.map { $0.capitalized }.joined()
        case .lower:
            return textArray.lazy
                .enumerated()
                .map { index, text in
                    // only first index
                    if index == 0 {
                        return text.lowercased()
                    } else {
                        return text.capitalized
                    }
            }
            .joined()
        case .screamingSnake:
            return textArray.map { $0.uppercased() }.joined(separator: "_")
        case .snake:
            return textArray.map { $0.lowercased() }.joined(separator: "_")
        case .kebab:
            return textArray.map { $0.lowercased() }.joined(separator: "-")
        case .train:
            return textArray.map { $0.capitalized }.joined(separator: "-")
        }
    }
}
