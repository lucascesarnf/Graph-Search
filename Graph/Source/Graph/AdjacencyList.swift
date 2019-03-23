//
//  AdjacencyList.swift
//  Graph
//
//  Created by Lucas César  Nogueira Fonseca on 20/03/19.
//  Copyright © 2019 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation

open class AdjacencyList<T: Hashable> {
    // -- Keep the adjacentList like a dictionary
    public var adjacencyDict : [Vertex<T>: [Edge<T>]] = [:]
    public init() {}
    
    // MARK: - Helper Functions
    fileprivate func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight) // 1
        adjacencyDict[source]?.append(edge) // 2
    }
    
    fileprivate func addUndirectedEdge(vertices: (Vertex<Element>, Vertex<Element>), weight: Double?) {
        let (source, destination) = vertices
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
}

extension AdjacencyList: Graphable {
    public var description: CustomStringConvertible {
        var result = ""
        for (vertex, edges) in adjacencyDict {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [ \(edgeString) ] \n ")
        }
        return result
    }
    

    
    public func createVertex(data: Element) -> Vertex<Element> {
        let vertex = Vertex(data: data)
        
        if adjacencyDict[vertex] == nil {
            adjacencyDict[vertex] = []
        }
        
        return vertex
    }
    
    public func add(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        switch type {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(vertices: (source, destination), weight: weight)
        }
    }
    
    public func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? {
        guard let edges = adjacencyDict[source] else { return nil }
        
        for edge in edges {
            if edge.destination == destination {
                return edge.weight
            }
        }
        
        return nil
    }

    
    public func edges(from source: Vertex<Element>) -> [Edge<Element>]? {
        return adjacencyDict[source]
    }
    
    public typealias Element = T
}
