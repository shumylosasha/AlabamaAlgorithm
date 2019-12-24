//
//  Functions.swift
//  CMD
//
//  Created by Serge Vysotsky on 29.09.2019.
//  Copyright © 2019 Serge Vysotsky. All rights reserved.
//

import Foundation

extension Substring {
    func parseSentence() -> [SentencePart] {
        var result = [SentencePart]()
        
        print(self)
        
        var skipRanges = Set<Range<Index>>()
        var gotoIndex: Index?
        
        for index in indices {
            if let goto = gotoIndex {
                if index == goto {
                    gotoIndex = nil
                } else {
                    continue
                }
            }
            
            if skipRanges.contains(where: { $0.contains(index) }) {
                continue
            }
            
            switch self[index] {
            case ">":
                if let openBracketIndex = self[index...].firstIndex(of: "["), let closeBracketIndex = findClosingBracketIndex(forOpenBracketAt: openBracketIndex) {
                    gotoIndex = self.index(after: closeBracketIndex)
                    
                    let range = self.range(of: self[index..<openBracketIndex].appending("<"))!
                    skipRanges.insert(range)
                    
                    let rule = tryParseRule(at: index, goto: &gotoIndex)
                    let substring = self[index...closeBracketIndex]
                    let startEnd = StartEnd(substring: substring, endpoing: range, rule: rule, children: substring.trimming(CharacterSet(charactersIn: "[]")).parseSentence())
                    print("Got start end: \(startEnd)")
                }
            case "[":
                if let closeBracketIndex = findClosingBracketIndex(forOpenBracketAt: index) {
                    gotoIndex = self.index(after: closeBracketIndex)
                    
                    let rule = tryParseRule(at: index, goto: &gotoIndex)
                    let substring = self[index...closeBracketIndex]
                    let brackets = Brackets(substring: substring, rule: rule, children: substring.trimming(CharacterSet(charactersIn: "[]")).parseSentence())
                }
            case ",":
                let comma = Comma(substring: self[index..<self.index(after: index)])
                print("Got comma: \(comma)")
            case let char where CharacterSet.letters.containsUnicodeScalars(of: char):
                if let word = tryParseWord(at: index, parent: nil, goto: &gotoIndex) {
                    print("Got word: \(word)")
                }
            case "(":
                if let group = tryParseGroup(at: index, parent: nil, goto: &gotoIndex) {
                    print("Got group: \(group)")
                }
            default:
                break
            }
            
        }

        return result
    }
    
    func parseBracketsContent(at index: Index) -> [SentencePart] {
        var result = [SentencePart]()
        let range = index...findClosingBracketIndex(forOpenBracketAt: index)!
        let substring = self[range]
        let content = substring.trimming(CharacterSet(charactersIn: "[]"))
        return result
    }
    
    // helper
    
    func findClosingBracketIndex(forOpenBracketAt index: Index) -> Index? {
        var openCounter = 0
        for indice in self[index...].indices {
            switch self[indice] {
            case "[":
                openCounter += 1
            case "]":
                openCounter -= 1
            default:
                continue
            }
            
            if openCounter == 0 {
                return indice
            }
        }
        
        return nil
    }
    
    //
    
    func tryParseWord(at index: Index, parent: EmbedderSentencePart?, goto gotoIndex: inout Index?) -> Word? {
        if let wordEndIndex = self[index...].firstIndex(of: CharacterSet.letters.inverted) {
            gotoIndex = self.index(after: wordEndIndex)
            let rule = tryParseRule(at: wordEndIndex, goto: &gotoIndex)
            return Word(substring: self[index..<wordEndIndex], rule: rule ?? (parent as? RuledSentencePart)?.rule)
        }
        
        return nil
    }
    
    func tryParseGroup(at index: Index, parent: EmbedderSentencePart?, goto gotoIndex: inout Index?) -> Group? {
        if let groupEndIndex = self[index...].firstIndex(of: ")") {
            gotoIndex = self.index(after: groupEndIndex)
            let rule = tryParseRule(after: groupEndIndex, goto: &gotoIndex)
            return Group(substring: self[index...groupEndIndex], rule: rule ?? (parent as? RuledSentencePart)?.rule)
        }
        
        return nil
    }
    
    func tryParseRule(at index: Index, goto gotoIndex: inout Index?) -> Rule? {
        if self[index] == "{" {
            if let ruleEndIndex = self[index...].firstIndex(of: "}") {
                gotoIndex = self.index(after: ruleEndIndex)
                return Rule(substring: self[index...ruleEndIndex])
            }
        }
        
        return nil
    }
    
    func tryParseRule(after index: Index, goto gotoIndex: inout String.Index?) -> Rule? {
        if let next = self.index(index, offsetBy: 1, limitedBy: endIndex) {
            return tryParseRule(at: next, goto: &gotoIndex)
        }
        
        return nil
    }
}

