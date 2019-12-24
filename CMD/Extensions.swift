//
//  Extensions.swift
//  CMD
//
//  Created by Serge Vysotsky on 28.09.2019.
//  Copyright © 2019 Serge Vysotsky. All rights reserved.
//

import Foundation

extension Dictionary {
    subscript(_ key: Key?) -> Value? {
        set {
            if let key = key {
                self[key] = newValue
            }
        }
        
        get {
            key.flatMap({ self[$0] })
        }
    }
    
    subscript(_ key: Key?, or value: Value) -> Value {
        set {
            if let key = key {
                self[key] = newValue
            }
        }
        
        get {
            key.flatMap { self[$0, default: value] } ?? value
        }
    }
}

extension Array {
    func appending(_ newElement: Element) -> Array {
        var result = self
        result.append(newElement)
        return result
    }
    
    func appending<S: Sequence>(contentsOf newElements: S) -> Array where S.Element == Element {
        var result = self
        result.append(contentsOf: newElements)
        return result
    }
    
    // index
    
    func element(at index: Index) -> Element? {
        guard (0..<count).contains(index) else { return nil }
        return self[index]
    }
}

extension Dictionary {
    func mapKeys<K: Hashable>(_ keyPath: KeyPath<Key, K>) -> [K: Value] {
        return reduce(into: [:]) { (result, element) in
            result[element.key[keyPath: keyPath]] = element.value
        }
    }
    
    func removingValue(forKey key: Key) -> Dictionary {
        var result = self
        result.removeValue(forKey: key)
        return result
    }
}

extension Collection {
    func sorted<C: Comparable>(for keyPath: KeyPath<Element, C>, by descriptor: (C, C) -> Bool) -> [Element] {
        return sorted(by: { descriptor($0[keyPath: keyPath], $1[keyPath: keyPath]) })
    }
    
    func filter<E: Equatable>(where keyPath: KeyPath<Element, E>, isComparedTo value: E, by comparer: (E, E) -> Bool) -> [Element] {
        return filter { element in comparer(element[keyPath: keyPath], value) }
    }
    
    func map<ElementOfResult>(_ keyPath: KeyPath<Element, ElementOfResult>) -> [ElementOfResult] {
        return map { $0[keyPath: keyPath] }
    }
    
    func compactMap<ElementOfResult>(_ keyPath: KeyPath<Element, ElementOfResult?>) -> [ElementOfResult] {
        return compactMap { $0[keyPath: keyPath] }
    }
}

extension Array where Element: Hashable {
    var set: Set<Element> {
        Set(self)
    }
}

extension Set {
    var array: Array<Element> {
        Array(self)
    }
}

extension String.SubSequence {
    func trimming(_ set: CharacterSet) -> String.SubSequence {
        guard !isEmpty else { return self }
        var result = self
        
        var index = result.startIndex
        while let first = result[index].unicodeScalars.first, set.contains(first) {
            result.removeFirst()
            index = result.startIndex
        }
        
        index = result.index(before: result.endIndex)
        while let last = result[index].unicodeScalars.first, set.contains(last) {
            result.removeLast()
            index = result.index(before: result.endIndex)
        }
        
        return result
    }
    
    func parts(separatedBy separator: CharacterSet) -> [String.SubSequence] {
        var separatorIndices = [Substring.Index]()
        var result = [String.SubSequence]()
        
        for index in indices {
            if separator.containsUnicodeScalars(of: self[index]) {
                separatorIndices.append(index)
            }
        }
        
        for (i, index) in separatorIndices.enumerated() where i < separatorIndices.count - 1 {
            result.append(self[self.index(after: index)...separatorIndices[i + 1]])
        }
        
        return result
    }
    
    func parts(separatedBy separator: Character) -> [String.SubSequence] {
        var separatorIndices = [Substring.Index]()
        var result = [String.SubSequence]()
        
        for index in indices {
            if separator == self[index] {
                separatorIndices.append(index)
            }
        }
        
        if !separatorIndices.isEmpty {
            result.append(self[startIndex..<separatorIndices[0]])
            for (i, index) in separatorIndices.enumerated() where i < separatorIndices.count - 1 {
                result.append(self[self.index(after: index)..<separatorIndices[i + 1]])
            }
            
            result.append(self[index(after: separatorIndices.last!)...])
        }
        
        return result
    }
}

extension CharacterSet {
    func containsUnicodeScalars(of character: Character) -> Bool {
        return character.unicodeScalars.allSatisfy(contains(_:))
    }
}

extension Substring {
    public func firstIndex(of set: CharacterSet) -> String.Index? {
        for index in indices {
            if set.containsUnicodeScalars(of: self[index]) {
                return index
            }
        }
        
        return nil
    }
}

extension String {
    func next(after index: Index) -> Character? {
        if let index = self.index(index, offsetBy: 1, limitedBy: endIndex) {
            return self[index]
        }
        
        return nil
    }
}
