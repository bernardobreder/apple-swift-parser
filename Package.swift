//
//  Package.swift
//  SwiftParser
//
//

import PackageDescription

let package = Package(
	name: "SwiftParser",
	targets: [
		Target(name: "SwiftParser", dependencies: ["Lexer"]),
		Target(name: "Lexer", dependencies: []),
	]
)

