//
//  SwiftParser.swift
//  SwiftParser
//
//  Created by Bernardo Breder on 21/01/17.
//
//

import XCTest
@testable import SwiftParser

class SwiftParserTests: XCTestCase {

	func test() throws {
        XCTAssertEqual(1, try SwiftLexer().lex(input: "abc").count)
        XCTAssertEqual(3, try SwiftLexer().lex(input: "a  b  c").count)
        XCTAssertEqual(6, try SwiftLexer().lex(input: "{$0} #define").count)
        XCTAssertEqual(4, try SwiftLexer().lex(input: "a().").count)
        XCTAssertEqual(2, try SwiftLexer().lex(input: "//a\na").count)
        XCTAssertEqual(3, try SwiftLexer().lex(input: "// dasdsada\n// bbbbb\na").count)
        XCTAssertEqual(1, try SwiftLexer().lex(input: "// dasdsada").count)
        XCTAssertEqual(4, try SwiftLexer().lex(input: "@testable import a").count)
        XCTAssertEqual(0, try SwiftLexer().lex(input: " ").count)
        XCTAssertEqual(0, try SwiftLexer().lex(input: "").count)
        XCTAssertEqual(25, try SwiftLexer().lex(input: "(){}.;:,||&&$#@!?*/-+=<>~").count)
	}

}

