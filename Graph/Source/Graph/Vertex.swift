//
//  Vertex.swift
//  Graph
//
//  Created by Lucas César  Nogueira Fonseca on 20/03/19.
//  Copyright © 2019 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation

public struct Vertex<T: Hashable> {
    var data: T
}

// -- Provide hash and equatable protocol
extension Vertex: Hashable {
    public var hashValue: Int { // 1
        return "\(data)".hashValue
    }
    
    static public func ==(lhs: Vertex, rhs: Vertex) -> Bool { // 2
        return lhs.data == rhs.data
    }
}

// -- Provide description to Vertex data
extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(data)"
    }
}

// -- Provide
