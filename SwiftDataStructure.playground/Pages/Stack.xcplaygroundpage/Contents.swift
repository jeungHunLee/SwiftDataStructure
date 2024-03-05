//
//  Stack.swift
//  SwiftDataStructure
//
//  Created by 이정훈 on 2/25/24.
//

struct Stack<Element> {
    private var items = Array<Element>()
    var count: Int {
        return items.count
    }
    var first: Element? {
        return items.first
    }
    
    var last: Element? {
        return items.last
    }
    
    mutating func push(_ item: Element) {
        self.items.append(item)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else {
            return nil
        }
        
        return items.removeLast()
    }
    
    func dump() {
        print("[", terminator: "")
        
        for i in 0..<items.count {
            print(items[i], terminator: i == items.count - 1 ? "" : ", ")
        }
        
        print("]")
    }
    
    func map<T>(transform: (Element) -> T) -> Stack<T> {
        var tempStack = Stack<T>()
        
        for item in items {
            tempStack.items.append(transform(item))
        }
        
        return tempStack
    }
    
    func filter(filteringMethod: (Element) -> Bool) -> Stack<Element> {
        var filteredStack = Stack<Element>()
        
        for item in items {
            if filteringMethod(item) {
                filteredStack.items.append(item)
            } else {
                continue
            }
        }
        
        return filteredStack
    }
    
    func reduce<Result>(_ initialResult: Result, nextPartialResult: (Result, Element) -> Result) -> Result {
        var result = initialResult
        
        for item in items {
            result = nextPartialResult(result, item)
        }
        
        return result
    }
    
    subscript(_ index: Int) -> Element? {
        guard 0 <= index && index < items.count else {
            return nil
        }
        
        return items[index]
    }
    
    subscript<Indices: Sequence>(_ indices: Indices) -> [Element] where Indices.Iterator.Element == Int {
        var result = [Element]()
        for index in indices {
            guard index >= 0 && index < items.count else {
                continue
            }
            
            result.append(items[index])
        }
        
        return result
    }
}

//MARK: - example
//var stack: Stack<Int> = Stack<Int>()
//for i in 1...10 {
//    stack.push(i)
//}
//
//stack.dump()    //[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
//print(stack[1...5])    //[2, 3, 4, 5, 6]
//
//print(stack.pop())    //10
//print(stack.pop())    //9
//
//stack.dump()     //[1, 2, 3, 4, 5, 6, 7, 8]
