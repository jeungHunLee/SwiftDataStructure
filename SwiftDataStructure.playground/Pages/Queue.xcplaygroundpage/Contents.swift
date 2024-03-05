struct Queue<Element> {
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
    
    mutating func enqueue(_ item: Element) {
        items.append(item)
    }
    
    mutating func dequeue() -> Element? {
        guard !items.isEmpty else {
            return nil
        }
        
        return items.removeFirst()
    }
    
    func dump() {
        print("[", terminator: "")
        
        for i in 0..<items.count {
            print(items[i], terminator: i == items.count - 1 ? "" : ", ")
        }
        
        print("]")
    }
    
    subscript (_ index: Int) -> Element? {
        guard 0 <= index && index < items.count else {
            return nil
        }
        
        return items[index]
    }
}
