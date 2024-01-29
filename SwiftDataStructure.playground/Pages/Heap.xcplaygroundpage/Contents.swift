//
//  Heap.swift
//  SwiftDataStructure
//
//  Created by 이정훈 on 1/29/24.
//

import Foundation

public struct Heap<T: Comparable> {
    private var nodes: Array<T>
    private let orderCriteria: (T, T) -> Bool
    
    public init(_ nodes: Array<T>, orderCriteria: @escaping (T, T) -> Bool) {
        self.nodes = nodes
        self.orderCriteria = orderCriteria
    }
    
    //MARK: - Count function
    ///return number of data
    public func count() -> Int {
        return nodes.count
    }
    
    //MARK: - Enqueue Data
    ///push data to  heap
    mutating public func push(_ element: T) {
        nodes.append(element)
        
        swapUp(nodes.count - 1)
    }
    
    //MARK: - Dequeue Data
    ///pop data from heap
    mutating public func pop() -> T? {
        guard !nodes.isEmpty else { return nil }
        swap(0, nodes.count - 1)
        
        let value = nodes.removeLast()
        swapDown(0)
        
        return value
    }
    
    //MARK: - Swap Data
    ///Data exchange between two nodes
    mutating private func swap(_ first: Int, _ second: Int) {
        guard first < nodes.count && second < nodes.count else { return }
        
        let temp = nodes[first]
        nodes[first] = nodes[second]
        nodes[second] = temp
    }
    
    //MARK: - swapUp
    ///heapify at the bottom node
    mutating private func swapUp(_ index: Int) {
        guard index < nodes.count else { return }
        var index = index
        
        while index != 0 {
            let parent = (index - 1) / 2    //index of parent node
            
            if orderCriteria(nodes[index], nodes[parent]) {
                swap(index, parent)
                index = parent
            } else {
                return
            }
        }
    }
    
    //MARK: - swapDown
    ///heapify at the top node
    mutating private func swapDown(_ index: Int) {
        var parent = index    //parent index
        
        while true {
            let leftChildIndex = parent * 2 + 1
            let rightChildIndex = leftChildIndex + 1
            var candidate = parent
            
            if leftChildIndex < nodes.count && orderCriteria(nodes[leftChildIndex], nodes[candidate]) {
                candidate = leftChildIndex
            }
            
            if rightChildIndex < nodes.count && orderCriteria(nodes[rightChildIndex], nodes[candidate]) {
                candidate = rightChildIndex
            }
            
            if candidate == parent {
                return
            }
            
            swap(candidate, parent)
            parent = candidate
        }
    }
}
