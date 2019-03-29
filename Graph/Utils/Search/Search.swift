//
//  BreadthFirst.swift
//  Graph
//
//  Created by Lucas César  Nogueira Fonseca on 21/03/19.
//  Copyright © 2019 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation

enum Search {
    static func breadthFirstSearch<Element>(_ adjacencyList: AdjacencyList<Element>, from vertexA: Vertex<Element>, to vertexB: Vertex<Element>) {
        print("\n\n****** Breadth-First Search ******")
        var queue = Queue<Vertex<Element>>()
        // Start the queue with the first element
        queue.enqueue(vertexA)
        
        var nodesExplored = [vertexA]
        
        // Dequeue element and look to edges
        while let current = queue.dequeue() {
            guard let edges = adjacencyList.adjacencyDict[current] else { return }
            
            for edge in edges {
                let vertex = edge.destination
                // See if the node isn't explored before
                if !nodesExplored.contains(vertex) {
                    queue.enqueue(vertex)
                    nodesExplored.append(vertex)
                }
               // Stop when destination is found
                if vertex == vertexB {
                    print(nodesExplored)
                    return
                }
            }
            print(nodesExplored)
        }
    }
    
    static func uniformBreadthFirstSearch<Element>(_ adjacencyList: AdjacencyList<Element>, from vertexA: Vertex<Element>, to vertexB: Vertex<Element>) {
        
        print("\n\n****** Uniform Breadth-First Search ******")
        
        typealias UniformVertex = (vertex: Vertex<Element>, cost: Double)
        
        var queue = Queue<UniformVertex>()
        
        // Start the queue with the first element and cost 0
        queue.enqueue((vertex: vertexA, cost: 0))
        
        var nodesExplored = [vertexA]
        
        // Dequeue element and look to edges
        while let current = queue.dequeue() {
            guard let edges = adjacencyList.adjacencyDict[current.vertex] else { return }
            var edgesString = ""
            let sortedEdges = edges.sorted(by: { ($0.weight ?? 0) < ($1.weight ?? 0)})
            
            // keep elements that will be queued
            var nodesToAppend = [UniformVertex]()
            
            for edge in sortedEdges {
                let vertex = edge.destination
                
                 //First we save the nodes that should be queued
                if !nodesExplored.contains(vertex) {
                    let cost = edge.weight ?? 0
                    let node = (vertex: vertex, cost: cost + current.cost)
                    edgesString += "|\(node.vertex)(\(node.cost))|"
                    nodesExplored.append(edge.destination)
                    nodesToAppend.append(node)
                }
                
                if vertex == vertexB {
                    print("[\(current)] - [\(edgesString)]")
                    return
                }
            }
            
            // Sort the 'nodesToAppend' to make sure that the less element will be queued first
            for node in nodesToAppend.sorted(by: { $0.cost < $1.cost }) {
                queue.enqueue(node)
            }
            
            print("[\(current)] - [\(edgesString)]")
        }
    }
    
    static func depthFirstSearch(from start: Vertex<String>, to end: Vertex<String>, graph: AdjacencyList<String>) {
        print("\n\n****** Depth First Search ******")
        let nodes = depthFirst(from: start, to: end, graph: graph)
        print(nodes)
    }
    
    static private func depthFirst(from start: Vertex<String>, to end: Vertex<String>, graph: AdjacencyList<String>) -> Stack<Vertex<String>> {
        var visited = Set<Vertex<String>>()
        var stack = Stack<Vertex<String>>()
        
        stack.push(start)
        visited.insert(start)
        
        outer: while let vertex = stack.peek(), vertex != end {
            
            guard let neighbours = graph.edges(from: vertex), neighbours.count > 0 else {
                stack.pop()
                continue
            }
            
            for edge in neighbours {
                if !visited.contains(edge.destination) {
                    visited.insert(edge.destination)
                    stack.push(edge.destination)
                    continue outer
                }
            }
            stack.pop()
            
        }
        return stack
    }
    
    static func aStarSearch(from start: Vertex<String>, to end: Vertex<String>, graph: AdjacencyList<String>, heuristicTable: [String:Double]) {
        print("\n\n****** A* Search ********")
        let nodes = aStar(from: start, to: end, graph: graph, heuristicTable: heuristicTable)
        print(nodes)
    }
    
    static func aStar(from start: Vertex<String>, to end: Vertex<String>, graph: AdjacencyList<String>, heuristicTable: [String:Double]) -> Stack<Vertex<String>> {
        var visited = Set<Vertex<String>>()
        var stack = Stack<Vertex<String>>()
        
        stack.push(start)
        visited.insert(start)
        
        typealias AStarData = (vert: Vertex<String>, f: Double)
        
        while let vertex = stack.peek(), vertex != end {
            guard let neighbours = graph.edges(from: vertex), neighbours.count > 0 else {
                stack.pop()
                continue
            }
            
            var edges = [AStarData]()
            
            for edge in neighbours {
                let currentVert = edge.destination
                if !visited.contains(currentVert) {
                     visited.insert(currentVert)
                    //compare the value of F() with the last element that entry on stack
                    edges.append((vert: currentVert, f: Search.funcAStar(g: edge.weight, h: heuristicTable[currentVert.data])))
                }
            }
            
            if let minF = edges.sorted(by: {$0.f < $1.f}).first {
                stack.push(minF.vert)
            }
        }
        
        return stack
    }
    
    
    private static func funcAStar(g: Double?, h: Double?) -> Double {
        return (g ?? 0) + (h ?? 0)
    }
}
