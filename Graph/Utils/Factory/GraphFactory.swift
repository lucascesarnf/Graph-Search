//
//  GraphFactory.swift
//  Graph
//
//  Created by Lucas César  Nogueira Fonseca on 21/03/19.
//  Copyright © 2019 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation

enum GraphFactory {
    case romania, world
    
    func initialize() -> AdjacencyList<String> {
        switch self {
        case .world:
            let adjacencyList = AdjacencyList<String>()
            let singapore = adjacencyList.createVertex(data: "Singapore")
            let tokyo = adjacencyList.createVertex(data: "Tokyo")
            let hongKong = adjacencyList.createVertex(data: "Hong Kong")
            let detroit = adjacencyList.createVertex(data: "Detroit")
            let sanFrancisco = adjacencyList.createVertex(data: "San Francisco")
            let washingtonDC = adjacencyList.createVertex(data: "Washington DC")
            let austinTexas = adjacencyList.createVertex(data: "Austin Texas")
            let seattle = adjacencyList.createVertex(data: "Seattle")
            
            adjacencyList.add(.undirected, from: singapore, to: hongKong, weight: 300)
            adjacencyList.add(.undirected, from: singapore, to: tokyo, weight: 500)
            adjacencyList.add(.undirected, from: hongKong, to: tokyo, weight: 250)
            adjacencyList.add(.undirected, from: tokyo, to: detroit, weight: 450)
            adjacencyList.add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
            adjacencyList.add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
            adjacencyList.add(.undirected, from: detroit, to: austinTexas, weight: 50)
            adjacencyList.add(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
            adjacencyList.add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
            adjacencyList.add(.undirected, from: washingtonDC, to: seattle, weight: 277)
            adjacencyList.add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
            adjacencyList.add(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)
            
            print(adjacencyList.description)
            
            return adjacencyList
        case .romania:
            let adjacencyList = AdjacencyList<String>()
            let arad = adjacencyList.createVertex(data: "Arad")
            let sibiu = adjacencyList.createVertex(data: "Sibiu")
            let zerind = adjacencyList.createVertex(data: "Zerind")
            let oradea = adjacencyList.createVertex(data: "Oradea")
            let fagaras = adjacencyList.createVertex(data: "Fagaras")
            let bucharest = adjacencyList.createVertex(data: "Bucharest") // <--
            let pitesti = adjacencyList.createVertex(data: "Pitesti")
            let craiova = adjacencyList.createVertex(data: "Craiova")
            let rimnicuVilcea = adjacencyList.createVertex(data: "Rimnicu Vilcea")
            
            adjacencyList.add(.undirected, from: arad, to: zerind, weight: 75)
            adjacencyList.add(.undirected, from: zerind, to: oradea, weight: 71)
            adjacencyList.add(.undirected, from: oradea, to: sibiu, weight: 151)
            adjacencyList.add(.undirected, from: arad, to: sibiu, weight: 140)
            adjacencyList.add(.undirected, from: sibiu, to: fagaras, weight: 99)
            adjacencyList.add(.undirected, from: sibiu, to: rimnicuVilcea, weight: 80)
            adjacencyList.add(.undirected, from: rimnicuVilcea, to: pitesti, weight: 97)
            adjacencyList.add(.undirected, from: craiova, to: rimnicuVilcea, weight: 146)
            adjacencyList.add(.undirected, from: craiova, to: pitesti, weight: 138)
            adjacencyList.add(.undirected, from: pitesti, to: bucharest, weight: 101)
            adjacencyList.add(.undirected, from: fagaras, to: bucharest, weight: 211)
            
            print(adjacencyList.description)
            
            return adjacencyList
        }
    }
}
