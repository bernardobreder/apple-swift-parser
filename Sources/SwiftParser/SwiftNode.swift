//
//  SwiftNode.swift
//  SwiftParser
//
//  Created by Bernardo Breder on 17/04/17.
//
//

import Foundation

open class SwiftContext {
    
    public init() {
    }
    
}

open class SwiftNode {
    
    public func value(_ context: SwiftContext) -> Any? {
        return nil
    }
    
}

open class SwiftValueNode: SwiftNode {
    
    public override func value(_ context: SwiftContext) -> Any? {
        return nil
    }
    
}

open class SwiftBlockValueNode: SwiftValueNode {
    
    let values: [SwiftValueNode]
    
    public init(values: [SwiftValueNode]) {
        self.values = values
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        for value in values {
            if let value = value.value(context) {
                return value
            }
        }
        return nil
    }
    
}

open class SwiftVariableValueNode: SwiftValueNode {
    
    let name: String
    
    public init(name: String) {
        self.name = name
    }
    
}

open class SwiftDefineValueNode: SwiftValueNode {
    
    let variables: [SwiftVariableValueNode]
    
    let values: [SwiftValueNode]
    
    public init(variables: [SwiftVariableValueNode], values: [SwiftValueNode]) {
        self.variables = variables
        self.values = values
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        return nil
    }
    
}

open class SwiftIfValueNode: SwiftValueNode {
    
    let condition: SwiftValueNode
    
    let command: SwiftValueNode
    
    public init(condition: SwiftValueNode, command: SwiftValueNode) {
        self.condition = condition
        self.command = command
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        if condition.value(context) as? Bool == true {
            return command.value(context)
        }
        return nil
    }
    
}

open class SwiftWhileValueNode: SwiftValueNode {
    
    let condition: SwiftValueNode
    
    let command: SwiftValueNode
    
    public init(condition: SwiftValueNode, command: SwiftValueNode) {
        self.condition = condition
        self.command = command
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        while condition.value(context) as? Bool == true {
            if let result = command.value(context) {
                return result
            }
        }
        return nil
    }
    
}

open class SwiftRepeatValueNode: SwiftValueNode {
    
    let condition: SwiftValueNode
    
    let command: SwiftValueNode
    
    public init(condition: SwiftValueNode, command: SwiftValueNode) {
        self.condition = condition
        self.command = command
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        repeat {
            if let result = command.value(context) {
                return result
            }
        } while condition.value(context) as? Bool == true
        return nil
    }
    
}

open class SwiftBreakValueNode: SwiftValueNode {
    
    public override func value(_ context: SwiftContext) -> Any? {
        return nil
    }
    
}

open class SwiftContinueValueNode: SwiftValueNode {
    
    public override func value(_ context: SwiftContext) -> Any? {
        return nil
    }
    
}

open class SwiftReturnValueNode: SwiftValueNode {
    
    let value: SwiftValueNode
    
    public init(_ value: SwiftValueNode) {
        self.value = value
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        return nil
    }
    
}

open class SwiftUpValueNode: SwiftValueNode {
    
    let value: SwiftValueNode
    
    public init(_ value: SwiftValueNode) {
        self.value = value
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        return nil
    }
    
}

open class SwiftOrValueNode: SwiftValueNode {
    
    let left: SwiftValueNode
    
    let right: SwiftValueNode
    
    public init(left: SwiftValueNode, right: SwiftValueNode) {
        self.left = left
        self.right = right
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        let l = left.value(context)
        let r = right.value(context)
        if let lb = l as? Bool {
            if let rb = r as? Bool {
                return lb || rb
            }
        }
        return nil
    }
    
}

open class SwiftAndValueNode: SwiftValueNode {
    
    let left: SwiftValueNode
    
    let right: SwiftValueNode
    
    public init(left: SwiftValueNode, right: SwiftValueNode) {
        self.left = left
        self.right = right
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        let l = left.value(context)
        let r = right.value(context)
        if let lb = l as? Bool {
            if let rb = r as? Bool {
                return lb && rb
            }
        }
        return nil
    }
    
}

open class SwiftEqualValueNode: SwiftValueNode {
    
    let left: SwiftValueNode
    
    let right: SwiftValueNode
    
    public init(left: SwiftValueNode, right: SwiftValueNode) {
        self.left = left
        self.right = right
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        let l = left.value(context)
        let r = right.value(context)
        if let lo = l as? NSObject {
            if let ro = r as? NSObject {
                return lo == ro
            }
        } else if let ln = l as? Double {
            if let rn = r as? Double {
                return ln == rn
            }
        } else if let ls = l as? String {
            if let rs = r as? String {
                return ls == rs
            }
        } else if let lb = l as? Bool {
            if let rb = r as? Bool {
                return lb == rb
            }
        }
        return nil
    }
    
}

open class SwiftNotEqualValueNode: SwiftValueNode {
    
    let left: SwiftValueNode
    
    let right: SwiftValueNode
    
    public init(left: SwiftValueNode, right: SwiftValueNode) {
        self.left = left
        self.right = right
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        let l = left.value(context)
        let r = right.value(context)
        if let lo = l as? NSObject {
            if let ro = r as? NSObject {
                return lo != ro
            }
        } else if let ln = l as? Double {
            if let rn = r as? Double {
                return ln != rn
            }
        } else if let ls = l as? String {
            if let rs = r as? String {
                return ls != rs
            }
        } else if let lb = l as? Bool {
            if let rb = r as? Bool {
                return lb != rb
            }
        }
        return nil
    }
    
}

open class SwiftLowerValueNode: SwiftValueNode {
    
    let left: SwiftValueNode
    
    let right: SwiftValueNode
    
    public init(left: SwiftValueNode, right: SwiftValueNode) {
        self.left = left
        self.right = right
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        let l = left.value(context)
        let r = right.value(context)
        if let ln = l as? Double {
            if let rn = r as? Double {
                return ln < rn
            }
        } else if let ln = l as? Double {
            if let rn = r as? Double {
                return ln < rn
            }
        } else if let ls = l as? String {
            if let rs = r as? String {
                return ls < rs
            }
        }
        return nil
    }
    
}

open class SwiftGreaterValueNode: SwiftValueNode {
    
    let left: SwiftValueNode
    
    let right: SwiftValueNode
    
    public init(left: SwiftValueNode, right: SwiftValueNode) {
        self.left = left
        self.right = right
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        let l = left.value(context)
        let r = right.value(context)
        if let ln = l as? Double {
            if let rn = r as? Double {
                return ln > rn
            }
        } else if let ln = l as? Double {
            if let rn = r as? Double {
                return ln > rn
            }
        } else if let ls = l as? String {
            if let rs = r as? String {
                return ls > rs
            }
        }
        return nil
    }
    
}

open class SwiftLowerEqualValueNode: SwiftValueNode {
    
    let left: SwiftValueNode
    
    let right: SwiftValueNode
    
    public init(left: SwiftValueNode, right: SwiftValueNode) {
        self.left = left
        self.right = right
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        let l = left.value(context)
        let r = right.value(context)
        if let ln = l as? Double {
            if let rn = r as? Double {
                return ln <= rn
            }
        } else if let ln = l as? Double {
            if let rn = r as? Double {
                return ln <= rn
            }
        } else if let ls = l as? String {
            if let rs = r as? String {
                return ls <= rs
            }
        }
        return nil
    }
    
}

open class SwiftGreaterEqualValueNode: SwiftValueNode {
    
    let left: SwiftValueNode
    
    let right: SwiftValueNode
    
    public init(left: SwiftValueNode, right: SwiftValueNode) {
        self.left = left
        self.right = right
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        let l = left.value(context)
        let r = right.value(context)
        if let ln = l as? Double {
            if let rn = r as? Double {
                return ln >= rn
            }
        } else if let ln = l as? Double {
            if let rn = r as? Double {
                return ln >= rn
            }
        } else if let ls = l as? String {
            if let rs = r as? String {
                return ls >= rs
            }
        }
        return nil
    }
    
}

open class SwiftPlusValueNode: SwiftValueNode {
    
    let left: SwiftValueNode
    
    let right: SwiftValueNode
    
    public init(left: SwiftValueNode, right: SwiftValueNode) {
        self.left = left
        self.right = right
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        let l = left.value(context)
        let r = right.value(context)
        if let ln = l as? Double {
            if let rn = r as? Double {
                return ln + rn
            } else {
                return ln
            }
        } else if let ls = l as? String {
            if let rs = r as? String {
                return ls + rs
            } else {
                return ls
            }
        }
        return nil
    }
    
}

open class SwiftMinusValueNode: SwiftValueNode {
    
    let left: SwiftValueNode
    
    let right: SwiftValueNode
    
    public init(left: SwiftValueNode, right: SwiftValueNode) {
        self.left = left
        self.right = right
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        let l = left.value(context)
        let r = right.value(context)
        if let ln = l as? Double {
            if let rn = r as? Double {
                return ln - rn
            } else {
                return ln
            }
        }
        return nil
    }
    
}

open class SwiftMultValueNode: SwiftValueNode {
    
    let left: SwiftValueNode
    
    let right: SwiftValueNode
    
    public init(left: SwiftValueNode, right: SwiftValueNode) {
        self.left = left
        self.right = right
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        let l = left.value(context)
        let r = right.value(context)
        if let ln = l as? Double {
            if let rn = r as? Double {
                return ln * rn
            } else {
                return ln
            }
        }
        return nil
    }
    
}

open class SwiftDivValueNode: SwiftValueNode {
    
    let left: SwiftValueNode
    
    let right: SwiftValueNode
    
    public init(left: SwiftValueNode, right: SwiftValueNode) {
        self.left = left
        self.right = right
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        let l = left.value(context)
        let r = right.value(context)
        if let ln = l as? Double {
            if let rn = r as? Double {
                return ln / rn
            } else {
                return ln
            }
        }
        return nil
    }
    
}

open class SwiftModValueNode: SwiftValueNode {
    
    let left: SwiftValueNode
    
    let right: SwiftValueNode
    
    public init(left: SwiftValueNode, right: SwiftValueNode) {
        self.left = left
        self.right = right
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        let l = left.value(context)
        let r = right.value(context)
        if let ln = l as? Double {
            if let rn = r as? Double {
                return Double(Int(ln) % Int(rn))
            } else {
                return ln
            }
        }
        return nil
    }
    
}

open class SwiftNotValueNode: SwiftValueNode {
    
    let left: SwiftValueNode
    
    public init(left: SwiftValueNode) {
        self.left = left
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        let l = left.value(context)
        if let lb = l as? Bool {
            return !lb
        }
        return nil
    }
    
}

open class SwiftNegValueNode: SwiftValueNode {
    
    let left: SwiftValueNode
    
    public init(left: SwiftValueNode) {
        self.left = left
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        let l = left.value(context)
        if let ld = l as? Double {
            return -ld
        }
        return nil
    }
    
}

open class SwiftNumberValueNode: SwiftValueNode {
    
    let value: Double
    
    public init(_ value: Double) {
        self.value = value
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        return value
    }
    
}

open class SwiftStringValueNode: SwiftValueNode {
    
    let value: String
    
    public init(_ value: String) {
        self.value = value
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        return value
    }
    
}

open class SwiftBooleanValueNode: SwiftValueNode {
    
    let value: Bool
    
    public init(_ value: Bool) {
        self.value = value
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        return value
    }
    
}

open class SwiftNilValueNode: SwiftValueNode {
    
    public override func value(_ context: SwiftContext) -> Any? {
        return nil
    }
    
}

open class SwiftIdentifierValueNode: SwiftValueNode {
    
    let value: String
    
    public init(_ value: String) {
        self.value = value
    }
    
    public override func value(_ context: SwiftContext) -> Any? {
        return nil
    }
    
}
