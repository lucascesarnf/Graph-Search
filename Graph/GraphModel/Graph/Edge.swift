//
//  Edge.swift
//  Graph
//
//  Created by Lucas César  Nogueira Fonseca on 20/03/19.
//  Copyright © 2019 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation

public enum EdgeType {
    case directed, undirected
}

public struct Edge<T: Hashable> {
    public var source: Vertex<T> // 1
    public var destination: Vertex<T>
    public let weight: Double? // 2
}

extension Edge: Hashable {
    public var hashValue: Int {
        return "\(source)\(destination)\(weight ?? 0)".hashValue
    }
    
    static public func ==(lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        return lhs.source == rhs.source &&
            lhs.destination == rhs.destination &&
            lhs.weight == rhs.weight
    }
}
