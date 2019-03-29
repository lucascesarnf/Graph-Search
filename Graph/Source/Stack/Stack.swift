//
//  Stack.swift
//  Graph
//
//  Created by Lucas César  Nogueira Fonseca on 22/03/19.
//  Copyright © 2019 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation

public struct Stack<T> where T: Equatable {
    fileprivate var array: [T] = []
    
    public init() {}
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    @discardableResult
    public func peek() -> T? {
        return array.last
    }
    
    public func contains(element: T) -> Bool {
        return array.contains {$0 == element}
    }
    
}

extension Stack: CustomStringConvertible {
    public var description: String {
        let topDivider = "---Stack---\n"
        let bottomDivider = "\n-----------\n"
        
        let stackElements = array.map { "\($0)" }.reversed().joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
}
