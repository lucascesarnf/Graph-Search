
Algorítmos de busca
=============

Neste diretório encontram-se os algoritmos aprendidos no livro `Artificial Intelligence Modern Approach`, implementados utilizando a linguagem `Swift`. 

 Parte 1:
 -------------------
 
Os algoritmos que encontram-se no arquivo `Graph-Search/Graph/Utils/Search/`:
1. Em Superfície:
```swift
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
```
2. Custo Uniforme:
```swift
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
```
3. Em Profundidade:
```swift
//This function consume the 'depthFirst' algorithm and print him
    static func depthFirstSearch(from start: Vertex<String>, to end: Vertex<String>, graph: AdjacencyList<String>) {
        print("\n\n****** Depth First Search ******")
        let nodes = depthFirst(from: start, to: end, graph: graph)
        print(nodes)
    }
    
    //This is the depthFirst algorithm
    static private func depthFirst(from start: Vertex<String>, to end: Vertex<String>, graph: AdjacencyList<String>) -> Stack<Vertex<String>> {
        var visited = Set<Vertex<String>>()
        var stack = Stack<Vertex<String>>()
        
        stack.push(start)
        visited.insert(start)
        
        //The while consume the stack
        outer: while let vertex = stack.peek(), vertex != end {
            
            guard let neighbours = graph.edges(from: vertex), neighbours.count > 0 else {
                stack.pop()
                continue
            }
            
            for edge in neighbours {
                if !visited.contains(edge.destination) {
                    visited.insert(edge.destination)
                    stack.push(edge.destination)
                    //Here i insert a new element at the stack and call the while again
                    continue outer
                }
            }
            stack.pop()
            
        }
        return stack
    }
```
4. A*:
```swift
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
    
    //Helper function to help the A * algorithm
    private static func funcAStar(g: Double?, h: Double?) -> Double {
        return (g ?? 0) + (h ?? 0)
    }
```
                
----

 Parte 2:
 -------------------
 
O algoritmo que encontram-se no arquivo `Graph-Search/Graph/Utils/Greedy/`:
```swift
private static func greedyAlgorithm( queens: inout [Queen]) {
        
        while finish(queens) {
            var board = boardWithQueenConflicts(queens: &queens)
            
        }
            
        var board = boardWithQueenConflicts(queens: &queens)
        print(board)

        print("################")
        for column in 0..<board.count {
            for line in 0..<board[column].count {
                if queens[column].line == line {
                    board[column][line] = queenNumber
                }
            }
        }
        print(board)
    }
    
    private static func boardWithQueenConflicts(queens: inout [Queen]) -> [[Int]] {
        let column = [Int](repeating: 0, count: queens.count)
        var board = [[Int]](repeating: column, count: queens.count)
        
        for column in 0..<board.count {
            for line in 0..<board[column].count {
          
                let numberOfConflicts = numberOfConflictsTo(line: line, column: column, queens: queens)
                board[column][line] = numberOfConflicts
                
                
                if queens[column].line == line {
                    queens[column].numberOfColisions = numberOfConflicts
                }
            }
        }
        
        return board
    }
    
    private static func numberOfConflictsTo(line: Int, column: Int, queens:[Queen]) -> Int {
        var count = 0
        for queen in queens {
            count += queen.collided(line: line, column: column) ? 1 : 0
        }
        return count
    }
    
    private static func finish(_ queens: [Queen]) -> Bool {
        var count = 0
        for queen in queens {
            count += queen.numberOfColisions == 0 ? 1 : 0
        }
        return count == queens.count
    }
```
Parte 3:
 -------------------
 O algoritmo que encontram-se no arquivo `Graph-Search/Graph/Utils/LocalSearch/`:
 ```swift
 ```
