//
//  Graphable.swift
//  Graph
//
//  Created by Lucas César  Nogueira Fonseca on 20/03/19.
//  Copyright © 2019 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation

protocol Graphable {
    associatedtype Element: Hashable // 1
    var description: CustomStringConvertible { get } // 2
    
    func createVertex(data: Element) -> Vertex<Element> // 3
    func add(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) // 4
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? // 5
    func edges(from source: Vertex<Element>) -> [Edge<Element>]? // 6
}
