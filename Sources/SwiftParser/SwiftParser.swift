//
//  SwiftParser.swift
//  SwiftParser
//
//  Created by Bernardo Breder on 21/01/17.
//
//

import Foundation

#if SWIFT_PACKAGE
    import Lexer
#endif

public enum SwiftParserError: Error {
    case expectedNumberValue
    case expectedStringValue
    case expectedTrueValue
    case expectedFalseValue
    case expectedNilValue
    case expectedRepeatValue
    case expectedWhileValue
    case expectedIfValue
    case expectedUpValue
    case expectedReturnValue
    case expectedContinueValue
    case expectedBreakValue
    case expectedVariableValue
    case expectedDefineValue
    case expectedLiteralValue
    case expectedIdentifierValue
    case expectedDoubleValue
}

open class SwiftParser {
    
    let tokens: [Token]
    
    var index: Int = 0
    
    public init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    public func parseExpression() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.If.rawValue:
            return try parseIf()
        case SwiftTokenType.Def.rawValue:
            return try parseDefine()
        case SwiftTokenType.While.rawValue:
            return try parseWhile()
        case SwiftTokenType.Repeat.rawValue:
            return try parseRepeat()
        case SwiftTokenType.Return.rawValue:
            return try parseReturn()
        case SwiftTokenType.Break.rawValue:
            return try parseBreak()
        case SwiftTokenType.Continue.rawValue:
            return try parseContinue()
        case SwiftTokenType.Up.rawValue:
            return try parseUp()
        default:
            return try parseOr()
        }
    }
    
    public func parseDefine() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.Def.rawValue:
            next()
            let variables: [SwiftVariableValueNode] = try parseVariableArray()
            var values: [SwiftValueNode] = []
            if case SwiftTokenType.Assign.rawValue = type() {
                next()
                values = try parseExpressionArray()
            }
            return SwiftDefineValueNode(variables: variables, values: values)
        default: throw SwiftParserError.expectedDefineValue
        }
    }
    
    public func parseVariable() throws -> SwiftVariableValueNode {
        switch type() {
        case SwiftTokenType.Identifier.rawValue:
            let word = self.word()
            next()
            return SwiftVariableValueNode(name: word)
        default: throw SwiftParserError.expectedVariableValue
        }
    }
    
    public func parseVariableArray() throws -> [SwiftVariableValueNode] {
        var array: [SwiftVariableValueNode] = []
        array.append(try parseVariable())
        while case SwiftTokenType.Comma.rawValue = type() {
            next()
            array.append(try parseVariable())
        }
        return array
    }
    
    public func parseExpressionArray() throws -> [SwiftValueNode] {
        var values: [SwiftValueNode] = []
        values.append(try parseExpression())
        while case SwiftTokenType.Comma.rawValue = type() {
            next()
            values.append(try parseExpression())
        }
        return values
    }
    
    public func parseBreak() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.Break.rawValue:
            next()
            return SwiftBreakValueNode()
        default:
            throw SwiftParserError.expectedBreakValue
        }
    }
    
    public func parseContinue() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.Continue.rawValue:
            next()
            return SwiftContinueValueNode()
        default:
            throw SwiftParserError.expectedContinueValue
        }
    }
    
    public func parseReturn() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.Return.rawValue:
            next()
            return SwiftReturnValueNode(try parseExpression())
        default:
            throw SwiftParserError.expectedReturnValue
        }
    }
    
    public func parseUp() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.Up.rawValue:
            next()
            return SwiftUpValueNode(try parseExpression())
        default:
            throw SwiftParserError.expectedUpValue
        }
    }
    
    public func parseIf() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.If.rawValue:
            next()
            let condition = try parseExpression()
            let command = try parseExpression()
            return SwiftIfValueNode(condition: condition, command: command)
        default:
            throw SwiftParserError.expectedIfValue
        }
    }
    
    public func parseWhile() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.While.rawValue:
            next()
            let condition = try parseExpression()
            let command = try parseExpression()
            return SwiftWhileValueNode(condition: condition, command: command)
        default:
            throw SwiftParserError.expectedWhileValue
        }
    }
    
    public func parseRepeat() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.Repeat.rawValue:
            next()
            let command = try parseExpression()
            let condition = try parseExpression()
            return SwiftRepeatValueNode(condition: condition, command: command)
        default:
            throw SwiftParserError.expectedRepeatValue
        }
    }
    
    public func parseOr() throws -> SwiftValueNode {
        let left = try parseAnd()
        switch type() {
        case SwiftTokenType.Or.rawValue:
            next()
            return SwiftOrValueNode(left: left, right: try parseOr())
        default:
            return left
        }
    }
    
    public func parseAnd() throws -> SwiftValueNode {
        let left = try parseCompare()
        switch type() {
        case SwiftTokenType.And.rawValue:
            next()
            return SwiftAndValueNode(left: left, right: try parseAnd())
        default:
            return left
        }
    }
    
    public func parseCompare() throws -> SwiftValueNode {
        let left = try parseSum()
        switch type() {
        case SwiftTokenType.Equal.rawValue:
            next()
            return SwiftEqualValueNode(left: left, right: try parseCompare())
        case SwiftTokenType.NotEqual.rawValue:
            next()
            return SwiftNotEqualValueNode(left: left, right: try parseCompare())
        case SwiftTokenType.Lower.rawValue:
            next()
            return SwiftLowerValueNode(left: left, right: try parseCompare())
        case SwiftTokenType.Greater.rawValue:
            next()
            return SwiftGreaterValueNode(left: left, right: try parseCompare())
        case SwiftTokenType.LowerEqual.rawValue:
            next()
            return SwiftLowerEqualValueNode(left: left, right: try parseCompare())
        case SwiftTokenType.GreaterEqual.rawValue:
            next()
            return SwiftGreaterEqualValueNode(left: left, right: try parseCompare())
        default:
            return left
        }
    }
    
    public func parseSum() throws -> SwiftValueNode {
        let left = try parseMul()
        switch type() {
        case SwiftTokenType.Plus.rawValue:
            next()
            return SwiftPlusValueNode(left: left, right: try parseSum())
        case SwiftTokenType.Minus.rawValue:
            next()
            return SwiftMinusValueNode(left: left, right: try parseSum())
        default:
            return left
        }
    }
    
    public func parseMul() throws -> SwiftValueNode {
        let left = try parseMod()
        switch type() {
        case SwiftTokenType.Mult.rawValue:
            next()
            return SwiftMultValueNode(left: left, right: try parseMul())
        case SwiftTokenType.Div.rawValue:
            next()
            return SwiftDivValueNode(left: left, right: try parseMul())
        default:
            return left
        }
    }
    
    public func parseMod() throws -> SwiftValueNode {
        let left = try parseUnary()
        switch type() {
        case SwiftTokenType.Mod.rawValue:
            next()
            return SwiftModValueNode(left: left, right: try parseMod())
        default:
            return left
        }
    }
    
    public func parseUnary() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.Not.rawValue:
            next()
            return SwiftNotValueNode(left: try parseLiteral())
        case SwiftTokenType.Minus.rawValue:
            next()
            return SwiftNegValueNode(left: try parseLiteral())
        default:
            return try parseLiteral()
        }
    }
    
    public func parseLiteral() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.ParensOpen.rawValue:
            next()
            let expr = try parseExpression()
            next()
            return expr
        case SwiftTokenType.Identifier.rawValue:
            return try parseIdentifier()
        case SwiftTokenType.True.rawValue:
            return try parseTrue()
        case SwiftTokenType.False.rawValue:
            return try parseFalse()
        case SwiftTokenType.String.rawValue:
            return try parseString()
        case SwiftTokenType.Nil.rawValue:
            return try parseNil()
        case SwiftTokenType.Number.rawValue:
            return try parseNumber()
        default:
            throw SwiftParserError.expectedLiteralValue
        }
    }
    
    public func parseIdentifier() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.Identifier.rawValue:
            let word = self.word()
            next()
            return SwiftIdentifierValueNode(word)
        default:
            throw SwiftParserError.expectedIdentifierValue
        }
    }
    
    public func parseNil() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.Nil.rawValue:
            next()
            return SwiftNilValueNode()
        default:
            throw SwiftParserError.expectedNilValue
        }
    }
    
    public func parseNumber() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.Number.rawValue:
            guard let word = Double(self.word()) else { throw SwiftParserError.expectedDoubleValue }
            next()
            return SwiftNumberValueNode(word)
        default:
            throw SwiftParserError.expectedNumberValue
        }
    }
    
    public func parseString() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.String.rawValue:
            let word = self.word()
            next()
            return SwiftStringValueNode(word)
        default:
            throw SwiftParserError.expectedStringValue
        }
    }
    
    public func parseTrue() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.True.rawValue:
            next()
            return SwiftBooleanValueNode(true)
        default:
            throw SwiftParserError.expectedTrueValue
        }
    }
    
    public func parseFalse() throws -> SwiftValueNode {
        switch type() {
        case SwiftTokenType.False.rawValue:
            next()
            return SwiftBooleanValueNode(false)
        default:
            throw SwiftParserError.expectedFalseValue
        }
    }
    
    func type() -> Int {
        guard index >= 0 && index < tokens.count else { return -1 }
        return tokens[index].type
    }
    
    func word() -> String {
        guard index >= 0 && index < tokens.count else { return "" }
        return tokens[index].word
    }
    
    func next() {
        index = index + 1
    }
    
}
