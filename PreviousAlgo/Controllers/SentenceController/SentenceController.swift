//
//  SentenceController.swift
//  Working
//
//  Created by Serhiy Vysotskiy on 9/22/18.
//  Copyright © 2018 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

public class SentenceController {
    let producer: String
    
    public init(generator: String) throws {
        producer = generator
        correctSentences = try generateSentences()
    }
    
    public var correctSentences: [String] = []
    var rules: [String: Int] = [:]
}



extension SentenceController {
    /// Generates sentences with the producer sentence
    ///
    /// - Returns: Array of correct sentences
    private func generateSentences() throws -> [String] {
        let clearedProducer = getRulesAndClearedProducerFromRules(producer)
        let producers = try getProducersFromProducerWithStartEndPoints(clearedProducer)
        return producers.reduce([String]()) { $0.appending(contentsOf: generate($1)) }.set.sorted()
    }
    
    
    /// Gets rules from producer
    ///
    /// - Parameter producer: Producer sentence with rules
    /// - Returns: Producer without rules
    private func getRulesAndClearedProducerFromRules(_ producer: String) -> String {
        var replacements: [String: String] = [:]
        
        for orderedRuleRegex in producer.find(regex: .orderedWordRuledRegex) {
            let rule = orderedRuleRegex.string.getRule()
            let ruleWord = orderedRuleRegex.string.replacing(regex: .orderedWordRuleRegex, with: .empty).wordsArray.first!
            let next = orderedRuleRegex.string.wordsArray.last!
            
            let lesss = orderedRuleRegex.string.find(regex: "[<]+").first!
            
            let workingString = orderedRuleRegex.string
                .replacingOccurrences(of: "{", with: "\\{")
                .replacingOccurrences(of: "}", with: "\\}")
            
            
            let wordsWithoutRules = "([a-zA-Z]+.){\(lesss.string.count.decremented)}"
            
            if let words = producer.find(regex: workingString + wordsWithoutRules).first?.string.wordsArray {
                print(words)
                
                let replacement = words.dropFirst().reduce(ruleWord + " ", { $0 + "\($1) " })
                replacements[orderedRuleRegex.string] = "\(ruleWord) \(next) "//replacement
                print(replacement)
                rules[replacement.stripped()] = rule
            }
            
        }
        
        for ruleRegex in producer.find(regex: .rulesForPhraseRegex) {
            let rule = ruleRegex.string.occurrences(of: .rulesRegex).first!.getRule()
            let cleared = ruleRegex.string.replacing(regex: .rulesRegex, with: .empty).removingBraces()
            rules[cleared] = rule
            replacements[ruleRegex.string] = cleared
        }
        
        for ruleRegex in producer.find(regex: .rulesForBracketsRegex) {
            let rule = ruleRegex.string.occurrences(of: .rulesRegex).first!.getRule()
            let cleared = ruleRegex.string.replacing(regex: .rulesRegex, with: .empty)
            cleared.removingBrackets().getCommaSeparated().forEach { (word) in
                rules[word] = rule
            }
            replacements[ruleRegex.string] = cleared
        }
        
        for ruleRegex in producer.find(regex: .rulesForWordRegex) {
            let rule = ruleRegex.string.occurrences(of: .rulesRegex).first!.getRule()
            let cleared = ruleRegex.string.replacing(regex: .rulesRegex, with: .empty)
            rules[cleared] = rule
            replacements[ruleRegex.string] = cleared
        }
        
        var clearedProducer = producer
        
        for (key, value) in replacements {
            clearedProducer = clearedProducer.replacingOccurrences(of: key, with: value)
        }
        
        return clearedProducer
    }
    
    
    /// Remove start end points and generates producers
    ///
    /// - Parameter producer: Producer string without rules but with start end points
    /// - Returns: Producers without start end points
    private func getProducersFromProducerWithStartEndPoints(_ producer: String) throws -> [String] {
        var startEndPairs = try producer.getStartEndPairs()
        
        guard !startEndPairs.isEmpty else {
            return [producer]
        }
        
        let startEndVariantsArray = [StartEndCase.start, StartEndCase.end]
        let product = CartesianProduct((0..<startEndPairs.count).map({ _ in startEndVariantsArray }))
        
        enum StartEndCase: Int {
            case start, end
        }
        
        startEndPairs.sort(by: { (pair1, pair2) -> Bool in
            pair1.start.range.lowerBound > pair2.start.range.lowerBound
        })
        
        
        var replaceQueue = [(place: RegexResult, case: StartEndCase, index: Int, replace: String)]()
        startEndPairs.enumerated().forEach { (value) in
            let (i, pair) = value
            let replace = pair.start.string.replacing(regex: .moreThan, with: .empty)
            replaceQueue.append((place: pair.start, case: .start, index: i, replace: replace))
            replaceQueue.append((place: pair.end, case: .end, index: i, replace: replace))
        }
        
        replaceQueue.sort(by: { $0.place.range.lowerBound > $1.place.range.lowerBound })
        
        var producers: [String] = []
        product.forEach { (combination) in
            let newProducer = replaceQueue.reduce(producer, { (result, object) in
                result.replacing(regexResult: object.place, with: object.case == combination[object.index] ? object.replace : .empty)
            }).cleared()
            
            producers.append(newProducer)
        }
        
        return producers
    }
    
    
    /// Generates correct sentences for producer
    ///
    /// - Parameter producer: Producer sentence without rules and start end pairs
    /// - Returns: Correct cleared sentences
    private func generate(_ producer: String) -> [String] {
        var results: [String] = []
        
        var bracketToVariantsDictionary = [String: [String]]()
        var bracketToRangesDictionary = [String: [Range<String.Index>]]()
        
        let occurences = producer.find(regex: .bracketsRegex)
        
        if occurences.isEmpty {
            results.append(producer)
        }
        
        for occurence in occurences {
            bracketToVariantsDictionary[occurence.string] = occurence.string.unwrappingBrackets()
            bracketToRangesDictionary[occurence.string, default: []].append(occurence.range)
        }
        
        
        // CartesianProduct
        
        let sortedKeys = bracketToVariantsDictionary.keys.sorted()
        let differentCombinations = sortedKeys.map { key in Array((0..<bracketToVariantsDictionary[key]!.count)) }
        let product = CartesianProduct(differentCombinations)
        
        for combination in product {
            let newSentence = sortedKeys.enumerated().reduce(producer) { (resultingString, enumeratedKey) in
                let (index, key) = enumeratedKey
                return resultingString.replacingOccurrences(of: key, with: bracketToVariantsDictionary[key]![combination[index]])
            }
            
            results.append(newSentence.cleared())
        }
        
        
        for (i, result) in results.enumerated() {
            guard let firstLetter = result.first.map({ String($0) }) else { continue }
            
            if firstLetter.uppercased() != firstLetter {
                results[i].replaceSubrange(result.stringRange(range: NSRange(location: 0, length: 1)), with: firstLetter.uppercased())
            }
            
            for regexResult in result.find(regex: .sentenceFirstLetterRegex) {
                if regexResult.string.dropFirst(regexResult.string.count - 1).uppercased() != regexResult.string.last.map(String.init) {
                    results[i].replaceSubrange(regexResult.range, with: regexResult.string.uppercased())
                }
            }
        }
        
        return results
    }
}
