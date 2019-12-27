//
//  CorrectSentence.swift
//  Working
//
//  Created by Serhiy Vysotskiy on 9/22/18.
//  Copyright © 2018 Serhiy Vysotskiy. All rights reserved.
//

public struct CorrectSentence {
    public let correct: String
    public let incorrect: String
    public let rules: [String : Rule]
    
    public init(correct: String, incorrect: String, rules: [String : Int]) {
        self.correct = correct
        self.incorrect = incorrect
        self.rules = rules.reduce([String: Rule](), { (result, element) in
            var partialResult = result
            partialResult[element.key] = allRules[String(element.value)]
            return partialResult
        })
    }
}

public extension CorrectSentence {
    func errorsWithRules() -> [String : Rule] {
        return rules.reduce([String: Rule](), { (result, element) in
            var temp = result
            let (key, value) = element
            if correct.lowercased().contains(key) && !incorrect.lowercased().contains(key) {
                temp[key] = value
            }
            
            return temp
        })
    }
    
    func errorParts() -> [String.StringIndexRange] {
        var result: [String.StringIndexRange] = []
        let correctWords = correct.words
        
        for regex in incorrect.find(regex: .englishWordRegex) {
            if !correctWords.contains(regex.string.lowercased()) {
                result.append(regex.range)
            }
        }
        
        return result
    }
    
    func correctedParts() -> [String.StringIndexRange] {
        var result: [String.StringIndexRange] = []
        let incorrectWords = incorrect.words
        
        for regex in correct.find(regex: .englishWordRegex) {
            if !incorrectWords.contains(regex.string.lowercased()) {
                result.append(regex.range)
            }
        }
        
        return result
    }
    
    var allowedToCheck: Bool {
        var result = true
        
        let count = incorrect.words.count
        if count == 0 || count < correct.words.count / 2 {
            result = false
        }
        
        return result
    }
}
