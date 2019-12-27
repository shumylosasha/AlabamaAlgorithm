//
//  StringExtensions.swift
//  Working
//
//  Created by Serhiy Vysotskiy on 10/15/18.
//  Copyright © 2018 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

extension String {
    func ends(with other: String) -> Bool {
        guard count >= other.count else { return false }
        return other.reversed().enumerated().allSatisfy { (index, character) -> Bool in
            return self[self.index(self.endIndex, offsetBy: -index.incremented)] == character
        }
    }
}

extension String {
    var withAllowedQuotationMark: String {
        return String.quotes.reduce(self, { $0.replacingOccurrences(of: String($1), with: "'") })
    }
}

extension String {
    var uppercasedFirst: String {
        return String(first!).uppercased() + String(dropFirst())
    }
}

extension Range where Bound == String.Index {
    var nsRange: NSRange {
        return NSRange(location: lowerBound.encodedOffset, length: upperBound.encodedOffset - lowerBound.encodedOffset)
    }
}

extension String {
    public var words: Set<String> {
        return removingPunctuation.lowercased().components(regex: .space).filter({ $0 != .empty }).set
    }
    
    public var wordsArray: [String] {
        return removingPunctuation.lowercased().components(regex: .space).filter({ $0 != .empty })
    }
    
    var sentences: [String] {
        return components(separatedBy: String.dot)
    }
    
    var reduceWords: [String: Int] {
        return wordsArray.reduce([String: Int](), { (result, element) in
            var temporaryResult = result
            temporaryResult[element, default: 0] += 1
            return temporaryResult
        })
    }
    
    var removingPunctuation: String {
        return self
            .replacingOccurrences(of: String.exclamationMark, with: String.empty)
            .replacingOccurrences(of: String.questionMark, with: String.empty)
            .replacingOccurrences(of: String.dot, with: String.empty)
            .replacingOccurrences(of: String.comma, with: String.empty)
            .replacingOccurrences(of: String.column, with: String.empty)
            .replacingOccurrences(of: String.semicolumn, with: String.empty)
            .replacingOccurrences(of: String.doubleSpace, with: String.space)
    }
}


// MARK: - Regex
extension String {
    public func components(regex separator: String) -> [String] {
        return components(separatedBy: separator)
    }
    
    mutating func strip() {
        if first == String.space.first {
            self = String(dropFirst())
        }
        
        if last == String.space.first {
            self = String(dropLast())
        }
    }
    
    func stripped() -> String {
        var new = self
        new.strip()
        return new
    }
    
    
    public typealias StringIndexRange = Range<String.Index>
    
    public mutating func replace(regex: String, with replacement: String, options: String.CompareOptions = [], range: Range<String.Index>? = nil) {
        self = replacingOccurrences(of: regex, with: replacement, options: String.CompareOptions.regularExpression.union(options), range: range)
    }
    
    public mutating func replace(regexResult: RegexResult, with replacement: String) {
        self = replacingOccurrences(of: regexResult.string, with: replacement, range: regexResult.range)
    }
    
    public func replacing(regex: String, with replacement: String, options: String.CompareOptions = [], range: Range<String.Index>? = nil) -> String {
        return replacingOccurrences(of: regex, with: replacement, options: String.CompareOptions.regularExpression.union(options), range: range)
    }
    
    public func replacing(regexResult: RegexResult, with replacement: String) -> String {
        return replacingOccurrences(of: regexResult.string, with: replacement, range: regexResult.range)
    }
    
    public func find(regex: String, regexOptions: NSRegularExpression.Options = [], matchingOptions: NSRegularExpression.MatchingOptions = [], partialRange: NSRange? = nil) -> [RegexResult] {
        return ranges(of: regex, regexOptions: regexOptions, matchingOptions: matchingOptions, partialRange: partialRange).map { RegexResult(string: String(self[$0]), range: $0, superString: self) }
    }
    
    public func occurrences(of regex: String, regexOptions: NSRegularExpression.Options = [], matchingOptions: NSRegularExpression.MatchingOptions = [], partialRange: NSRange? = nil) -> [String] {
        return ranges(of: regex, regexOptions: regexOptions, matchingOptions: matchingOptions, partialRange: partialRange).map { String(self[$0]) }
    }
    
    public func ranges(of regex: String, regexOptions: NSRegularExpression.Options = [], matchingOptions: NSRegularExpression.MatchingOptions = [], partialRange: NSRange? = nil) -> [StringIndexRange] {
        let predicate = try! NSRegularExpression(pattern: regex, options: regexOptions)
        let predicateMatches = predicate.matches(in: self, options: matchingOptions, range: partialRange ?? range)
        
        var matches = [StringIndexRange]()
        
        for match in predicateMatches {
            for rangeIndex in 0..<match.numberOfRanges {
                matches.append(stringRange(range: match.range(at: rangeIndex)))
            }
        }
        
        return matches
    }
}

// MARK: - Additional
extension String {
    var range: NSRange {
        return NSRange(location: 0, length: count)
    }
    
    public func stringRange(range: NSRange) -> StringIndexRange {
        return index(startIndex, offsetBy: range.location)..<index(startIndex, offsetBy: range.location + range.length)
    }
}


extension String {
    func cleared() -> String {
        let marks: [String] = [
            .space,
            .exclamationMark,
            .questionMark,
            .column,
            .semicolumn,
            .comma,
            .dot,
        ]
        
        let spaced = marks.map { String.space + $0 }
        
        let clearedSelf: String = spaced.enumerated()
            .reduce(self, { $0.replacingOccurrences(of: $1.element, with: marks[$1.offset]) })
            .stripped()
        
        if spaced.allSatisfy({ !clearedSelf.contains($0) }) {
            return clearedSelf
        } else {
            return clearedSelf.cleared()
        }
    }
    
    func unwrappingBrackets() -> [String] {
        var variantsInCurrentBrackets = removingBrackets().getCommaSeparated()
        
        for (i, variant) in variantsInCurrentBrackets.enumerated() {
            if variant.starts(with: regex.slash) {
                variantsInCurrentBrackets[i] = variant.replacingOccurrences(of: regex.slash, with: regex.empty)
                variantsInCurrentBrackets.append(.empty)
            }
        }
        
        return variantsInCurrentBrackets
    }
    
    func getStartEndPairs() throws -> [(start: RegexResult, end: RegexResult)] {
        let starts = find(regex: .startEndPartRegex)
        let ends = find(regex: .startEndPartEndingRegex)
        
        if starts.count != ends.count {
            throw SentenceControllerError.wrongStartEndPattern
        }
        
        var startStack = [RegexResult]()
        var pairs = [(RegexResult, RegexResult)]()
        (starts + ends).sorted(by: { $0.range.lowerBound < $1.range.lowerBound }).forEach { (result) in
            if result.string.isStartEndPairStart {
                startStack.append(result)
            }
            
            if result.string.isStartEndPairEnd {
                if let index = startStack.firstIndex(where: { (localResult) -> Bool in
                    let res = localResult.string.find(regex: "[>]+\\[").first!
                    return res.string.count == result.string.count
                }) {
                    let start = startStack[index]
                    pairs.append((start, result))
                }
            }
        }
        
        return pairs
    }
    
    var isStartEndPairStart: Bool {
        return !find(regex: regex.startEndPartRegex).isEmpty
    }
    
    var isStartEndPairEnd: Bool {
        return !find(regex: regex.startEndPartEndingRegex).isEmpty
    }
    
    func removingStartEndPoints() -> String {
        return replacing(regex: .startEndPartRegex, with: .empty).replacing(regex: .startEndPartEndingRegex, with: .empty)
    }
}

extension String {
    func removingBrackets() -> String {
        return replacingOccurrences(of: regex.openingBracket, with: regex.empty).replacingOccurrences(of: regex.closingBracket, with: regex.empty)
    }
    
    func removingStartEndBrackets() -> String {
        return replacing(regex: regex.startEndPartMoresRegex, with: regex.empty)
            .replacingOccurrences(of: regex.closingBracket, with: regex.empty)
        
    }
    
    func removingBraces() -> String {
        return replacingOccurrences(of: regex.openingBrace, with: regex.empty).replacingOccurrences(of: regex.closingBrace, with: regex.empty)
    }
    
    func getCommaSeparated() -> [String] {
        return components(separatedBy: regex.comma + .space)
    }
}


// Rules 
extension String {
    var hasRule: Bool {
        if contains(regex.openingCurlyBracket) && contains(regex.closingCurlyBracket),
            let startCurlyBracketIndex = lastIndex(of: regex.openingCurlyBracket.first!),
            let endCurlyBracketIndex = lastIndex(of: regex.closingCurlyBracket.first!),
            let _ = Int(String(self[index(after: startCurlyBracketIndex)..<endCurlyBracketIndex])) {
            return true
        }
        
        return false
    }
    
    func getRule() -> Int {
        guard let startCurlyBracketIndex = lastIndex(of: regex.openingCurlyBracket.first!),
            let endCurlyBracketIndex = lastIndex(of: regex.closingCurlyBracket.first!),
            let rule = Int(String(self[index(after: startCurlyBracketIndex)..<endCurlyBracketIndex])),
            hasRule
        else {
            fatalError()
        }
        
        return rule
    }
    
    func removingRules() -> String {
        return replacing(regex: .rulesRegex, with: .empty)
    }
    
    func removingEndRule() -> String {
        if hasRule {
            let rule = getRule()
            let ruleString = "{\(rule)}"
            
            if ends(with: ruleString) {
                var reverse = reversed().string
                reverse.replaceSubrange(stringRange(range: ruleString.range), with: regex.empty)
                return reverse.reversed().string
            }
        }
        
        return self
    }
}

extension ReversedCollection where Base == String {
    var string: String {
        return String(self)
    }
}
