//
//  CollectionsExtensions.swift
//  Working
//
//  Created by Serhiy Vysotskiy on 10/15/18.
//  Copyright © 2018 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

extension Array where Element: Equatable & Hashable {
    func filterRepeating() -> [Element] {
        var set = Set<Element>()
        return filter { element in
            let result = !set.contains(element)
            set.insert(element)
            return result
        }
    }
}

extension Array {
    func map<PathType>(_ path: KeyPath<Element, PathType>) -> [PathType] {
        return self.map { $0[keyPath: path] }
    }
}

extension Array {
    func pprint() {
        forEach { print($0) }
    }
}

extension Dictionary {
    func pprint() {
        forEach { print($0, $1) }
    }
}

extension Array where Element: Hashable {
    var set: Set<Element> {
        return Set(self)
    }
}

extension Set {
    var array: [Element] {
        return Array(self)
    }
}

extension Dictionary {
    func setting(_ value: Value?, for key: Key?) -> Dictionary {
        var dict = self
        key.map { dict[$0] = value }
        return dict
    }
}

extension Array {
    func dictionary<Key: Hashable>(with path: KeyPath<Element, Key>) -> Dictionary<Key, Element> {
        return reduce([Key: Element]()) { (result, element) in
            return result.setting(element, for: element[keyPath: path])
        }
    }
    
    func dictionary<Key: Hashable>(with path: KeyPath<Element, Key?>) -> Dictionary<Key, Element> {
        return reduce([Key: Element]()) { (result, element) in
            return result.setting(element, for: element[keyPath: path])
        }
    }
}

extension Array {
    func appending(_ newElement: Element) -> [Element] {
        var res = self
        res.append(newElement)
        return res
    }
    
    func appending(contentsOf array: [Element]) -> [Element] {
        var res = self
        res.append(contentsOf: array)
        return res
    }
}

extension Array {
    mutating func sort<C: Comparable>(keyPath: KeyPath<Element, C>, by sorter: (C, C) throws -> Bool) rethrows {
        try sort(by: { try sorter($0[keyPath: keyPath], $1[keyPath: keyPath]) })
    }
    
    func sorted<C: Comparable>(keyPath: KeyPath<Element, C>, by sorter: (C, C) throws -> Bool) rethrows -> Array {
        return try sorted(by: { try sorter($0[keyPath: keyPath], $1[keyPath: keyPath]) })
    }
}
