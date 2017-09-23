//
//  SwiftParserTests.swift
//  SwiftParser
//
//  Created by Bernardo Breder.
//
//

import XCTest
@testable import SwiftParserTests

extension SwiftParserTests {

	static var allTests : [(String, (SwiftParserTests) -> () throws -> Void)] {
		return [
			("test", test),
		]
	}

}

XCTMain([
	testCase(SwiftParserTests.allTests),
])

