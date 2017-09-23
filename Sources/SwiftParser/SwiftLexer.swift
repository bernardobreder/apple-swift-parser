//
//  SwiftLexer.swift
//  SwiftParser
//
//  Created by Bernardo Breder on 21/01/17.
//
//

import Foundation

#if SWIFT_PACKAGE
    import Lexer
#endif

public enum SwiftTokenType: Int {
    
    case Identifier
    case Number, Symbol
    case String
    case ParensOpen
    case ParensClose
    case Comma
    case Or, And, If, While, Repeat, For, Do, Def, Return, Up, Break, Continue
    case Plus, Minus, Mult, Div, Mod, Assign
    case Nil, True, False
    case Not, NotEqual, Equal, Lower, Greater, LowerEqual, GreaterEqual
    case EOF
    
}

open class SwiftLexer: Lexer {
    
    public override init() {
        super.init()
        keyword("false", type: { _ in SwiftTokenType.False.rawValue })
        keyword("do", type: { _ in SwiftTokenType.Do.rawValue })
        keyword("up", type: { _ in SwiftTokenType.Up.rawValue })
        keyword("or", type: { _ in SwiftTokenType.Or.rawValue })
        keyword("if", type: { _ in SwiftTokenType.If.rawValue })
        keyword("for", type: { _ in SwiftTokenType.For.rawValue })
        keyword("def", type: { _ in SwiftTokenType.Def.rawValue })
        keyword("nil", type: { _ in SwiftTokenType.Nil.rawValue })
        keyword("and", type: { _ in SwiftTokenType.And.rawValue })
        keyword("true", type: { _ in SwiftTokenType.True.rawValue })
        keyword("break", type: { _ in SwiftTokenType.Break.rawValue })
        keyword("while", type: { _ in SwiftTokenType.While.rawValue })
        keyword("repeat", type: { _ in SwiftTokenType.Repeat.rawValue })
        keyword("return", type: { _ in SwiftTokenType.Return.rawValue })
        keyword("continue", type: { _ in SwiftTokenType.Continue.rawValue })
        keyword("(", type: { _ in SwiftTokenType.ParensOpen.rawValue })
        keyword(")", type: { _ in SwiftTokenType.ParensClose.rawValue })
        keyword("!=", type: { _ in SwiftTokenType.NotEqual.rawValue })
        keyword("==", type: { _ in SwiftTokenType.Equal.rawValue })
        keyword("=", type: { _ in SwiftTokenType.Assign.rawValue })
        keyword("!=", type: { _ in SwiftTokenType.NotEqual.rawValue })
        keyword("<=", type: { _ in SwiftTokenType.LowerEqual.rawValue })
        keyword(">=", type: { _ in SwiftTokenType.GreaterEqual.rawValue })
        keyword("<", type: { _ in SwiftTokenType.Lower.rawValue })
        keyword(">", type: { _ in SwiftTokenType.Greater.rawValue })
        keyword(",", type: { _ in SwiftTokenType.Comma.rawValue })
        keyword("+", type: { _ in SwiftTokenType.Plus.rawValue })
        keyword("-", type: { _ in SwiftTokenType.Minus.rawValue })
        keyword("*", type: { _ in SwiftTokenType.Mult.rawValue })
        keyword("/", type: { _ in SwiftTokenType.Div.rawValue })
        keyword("!", type: { _ in SwiftTokenType.Not.rawValue })
        keyword("%", type: { _ in SwiftTokenType.Mod.rawValue })
        identifier = { _ in SwiftTokenType.Identifier.rawValue }
        string = { _ in SwiftTokenType.String.rawValue }
        number = { _ in SwiftTokenType.Number.rawValue }
        symbol = { _ in SwiftTokenType.Symbol.rawValue }
    }
    
}
