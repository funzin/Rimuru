//
//  InputTextError.swift
//  RimuruCore
//
//  Created by funzin on 2020/07/05.
//

import Foundation

public enum InputTextError: Error, CustomStringConvertible {
    case notConverted
    case notContainCapitalLetter
    case notFoundSeparator

    public var description: String {
        switch self {
        case .notFoundSeparator:
            return "Couldn't found separator in the input text"
        case .notContainCapitalLetter:
            return "The input text does not contain capital letter"
        case .notConverted:
            return "It's not a text format that can be converted"
        }
    }
}
