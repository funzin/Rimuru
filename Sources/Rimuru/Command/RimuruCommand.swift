//
//  RimuruCommand.swift
//  Rimuru
//
//  Created by funzin on 2020/07/05.
//

import ArgumentParser
import RimuruCore

struct RimuruCommand: ParsableCommand {
    static var configuration = CommandConfiguration(commandName: "rimuru",
                                                    abstract: "A tool for converting the input text to different naming convention",
                                                    discussion: "e.g Rimuru --from lower --to upper exampleTestCase",
                                                    version: "1.0.0")
    @Option(name: .shortAndLong, help: """
                                       Input text naming convention
                                       Select the following naming convention
                                       (upper|lower|screamingSnake|snake|kebab|train)
                                       \n
                                       """)
    var from: NamingConvention

    @Option(name: .shortAndLong, help: """
                                       Output text naming convention
                                       Select the following naming convention
                                       (upper|lower|screamingSnake|snake|kebab|train)
                                       \n
                                       """)
    var to: NamingConvention

    @Argument(help: "The text to be converted")
    var text: String

    mutating func run() throws {
        do {
            let result = try NamingConventionConverter.shared.convert(text: text,
                                                                      from: from,
                                                                      to: to)
            print(result)
        } catch {
            print(error.localizedDescription)
        }
    }
}
