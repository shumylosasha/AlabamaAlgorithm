//
//  SentenceController+FindCorrectOne.swift
//  Working
//
//  Created by Serhiy Vysotskiy on 10/6/18.
//  Copyright © 2018 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

extension SentenceController {
    /// Finds most correct sentence
    ///
    /// - Parameter userSentence: User input sentence
    /// - Returns: Correct sentence that corresponds the most to the user input
    public func findCorrectOne(for userSentence: String) -> CorrectSentence {
        let shouldContainWords = generateShouldContainWords(userSentence: userSentence)
        
        let correctNew = correctSentences.max { (s1, s2) -> Bool in
            return compare(s1, s2, transforms: [
                buildTransformer(transform: { $0.intersection(userSentence) }, compare: <),
                buildTransformer(transform: { $0.countSameWords(userSentence) }, compare: <),
                buildTransformer(transform: { $0.words.intersection(shouldContainWords.union(userSentence.words)).count }, compare: <),
                buildTransformer(transform: { $0.compareAgainstStartEndWords(userSentence) }, compare: <),
            ], comparer: >)
        }
        
        precondition(correctNew != nil)
        return CorrectSentence(correct: correctNew!, incorrect: userSentence, rules: rules)
    }
    
    
    /// Generates correct and incorrect words from user sentence
    ///
    /// - Parameter userSentence: User input
    /// - Returns: Set of words that might be correct but were mistaken by user
    private func generateShouldContainWords(userSentence: String) -> Set<String> {
        var scs = Set<String>()
        
        userSentence.words.forEach { (key) in
            if let wordsVariants = incorrectVerbsDict[key] {
                scs.formUnion(wordsVariants)
            }
            
            let word = key + "ed"
            let removingLast = String(key.dropLast())
            
            if let char = key.last {
                scs.insert(key + "\(char)ed")
            }
            
            scs.insert(word)
            scs.insert(removingLast + "ed")
            scs.insert(removingLast + "ied")
        }
        
        return scs
    }
}

// MARK: - Helping
extension SentenceController {
    private typealias IntComparer = (Int, Int) -> Bool
    private typealias StringToInt = (String) -> Int
    private typealias Transformer = (transform: StringToInt, compare: IntComparer)
    
    
    /// Compares two strings
    ///
    /// - Parameters:
    ///   - s1: First string
    ///   - s2: Second string
    ///   - transforms: Transform functions in which to compare
    ///   - comparer: How to compare final result of transforms
    /// - Returns: Result of final compare
    private func compare(_ s1: String, _ s2: String, transforms: [Transformer], comparer: IntComparer) -> Bool {
        var (winCount1, winCount2) = (0, 0)
        
        for transformer in transforms {
            let result = (transformer.transform(s1), transformer.transform(s2))
            
            if transformer.compare(result.0, result.1) {
                winCount1 += 1
            }
            
            if transformer.compare(result.1, result.0) {
                winCount2 += 1
            }
        }
        
        return comparer(winCount1, winCount2)
    }
    
    private func buildTransformer(transform: @escaping StringToInt, compare: @escaping IntComparer) -> Transformer {
        return (transform, compare)
    }
}


// MARK: - Sentence comparing helping functions
extension String {
    /// Counts first and last words in sentence
    ///
    /// - Parameter other: Sentence to count for
    /// - Returns: Count of equal starts/ends
    fileprivate func compareAgainstStartEndWords(_ other: String) -> Int {
        var c = 0
        
        let firstLast1 = sentences.reduce([String?](), { result, element in
            var new = result
            new.append(element.wordsArray.first)
            new.append(element.wordsArray.last)
            return new
        }).compactMap({ $0 })
        
        let firstLast2 = other.sentences.reduce([String?](), { result, element in
            var new = result
            new.append(element.wordsArray.first)
            new.append(element.wordsArray.last)
            return new
        }).compactMap({ $0 })
        
        for i in 0..<min(firstLast1.count, firstLast2.count) {
            if firstLast1[i] == firstLast2[i] {
                c += 1
            }
        }
        
        return c
    }
    
    /// Counts same words count
    ///
    /// - Parameter other: Sentence to count with
    /// - Returns: Number of common words
    fileprivate func intersection(_ other: String) -> Int {
        return words.intersection(other.words).count
    }
    
    /// Counts same words considering repeating words
    ///
    /// - Parameter string: String to count with
    /// - Returns: Number of common words
    fileprivate func countSameWords(_ string: String) -> Int {
        var userWords = string.wordsArray
        return wordsArray.filter({ element in
            if let index = userWords.firstIndex(of: element) {
                userWords.remove(at: index)
                return true
            }
            
            return false
        }).count
    }
}

