//
//  Correct.swift
//  EnglishPlanetEngine
//
//  Created by Serhiy Vysotskiy on 2/26/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

public class Correct {
    public let sentence: Sentence
    public let mostLikelyCorrect: String
    public let userSentence: Sentence
    var inputErrors = [String.StringIndexRange]()
    
    public var representations: [RepresentationPart] {
        return sentence.variants[mostLikelyCorrect]!.filter({ !($0 is EmptyRepresentationPart) })
    }
    
    
    
    init(sentence: Sentence, mostLikelyCorrect: String, userSentence: String) {
        self.sentence = sentence
        self.userSentence = Sentence(userSentence)
        self.mostLikelyCorrect = mostLikelyCorrect
    }
}

public extension Correct {
    internal func corresponding() -> [Int: (user: RepresentationPart, correct: RepresentationPart)] {
        var result = [Int: (user: RepresentationPart, correct: RepresentationPart)]()
        
        let userInputSentence = userSentence
//        userInputSentence.parts.map { $0.part }.pprint()
//        userInputSentence.sentences.pprint()
        
        var userParts = userInputSentence.findCorrectOne(for: userSentence.producer).representations
        var correctParts = representations
        
        let conditions: [(RepresentationPart, RepresentationPart) -> (Bool)] = [
            { $0.part == $1.part },
            { $1.part.contains($0.part) },
            { $0.part.contains($1.part) },
        ]
        
        for condition in conditions {
            var correctIndexesToRemove: Set<Int> = []
            
            for (correctIndex, correctPart) in correctParts.enumerated() where !correctIndexesToRemove.contains(correctIndex) {
                if let userPartIndex = userParts.firstIndex(where: { condition($0, correctPart) }) {
                    let userPart = userParts.remove(at: userPartIndex)
                    result[correctIndex] = (userPart, correctPart)
                    correctIndexesToRemove.insert(correctIndex)
//                    print(correctIndex, correctPart.part, userPart.part)
                }
            }
            
            correctIndexesToRemove.sorted(by: >).forEach { correctParts.remove(at: $0) }
        }
        
//        print(userParts.map(\.part))
        return result
    }
    
    
    func errorsWithRules() -> [String : Rule] {
        var result = [String: Rule]()
        
        for representation in representations {
            let (representationPart, rule) = (representation.part.lowercased(), representation.rule)
            let common = mostLikelyCorrect.words.intersection(userSentence.producer.words)
            
            if mostLikelyCorrect.lowercased().contains(representationPart) && (!userSentence.producer.lowercased().contains(representationPart) || common.intersection(representationPart.words).count == 0) {
                result[representationPart] = (rule?.description).flatMap { allRules[$0] }
            }
            
            if representation.parent is OrderedPart {
                let ordered = representation.parent as! OrderedPart
                let orderedVariants = ordered.orderedVariants
                let orderCheck = userSentence.producer.wordsArray.joined(separator: .space)
                let containsOrderedParts = orderedVariants.reduce(false, { $0 || orderCheck.contains($1) })
                
                if !containsOrderedParts, let rule = rule {
                    result[representation.part] = allRules[rule.description]
                }
            }
        }
        
        
        ///check if order is the same
        
        if userSentence.producer == "" { return [:]}
        
        var mutatingStr = userSentence.producer
        
        
        var toDelete = [RegexResult]()
        
        //remove all wrong words
        for regex in mutatingStr.find(regex: .englishWordRegex) {
            
            if !mostLikelyCorrect.words.contains(regex.string.lowercased()) {
                toDelete.append(regex)
                //mutatingStr.removeSubrange(regex.range)
            }
        }
        
        if (toDelete.count != 0) {
            
            for index in (0..<toDelete.count).reversed() {
                mutatingStr.removeSubrange(toDelete[index].range)
            }
        }
        mutatingStr = mutatingStr.condenseWhitespace()
        mutatingStr = mutatingStr.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
       

        
        
        var result2 = [String: Rule]()
        var previsoulyFoundLowerBounds = 0
        
        for representation in representations {
            let (representationPart, rule) = (representation.part.lowercased(), representation.rule)
            
            //find range of representationPart in mostLikely
            
            if (representationPart == "") {continue}
            
            let rangeOfRepresenationPart = findRange (stringToFind: representationPart, lowerBounds:previsoulyFoundLowerBounds, whereToFind: mostLikelyCorrect)
            
            
            let r = findRange (stringToFind: "aren't you", lowerBounds:previsoulyFoundLowerBounds, whereToFind: mostLikelyCorrect)
            
            
            
            if (rangeOfRepresenationPart != NSRange(location: 0,length: 0))
            {
                previsoulyFoundLowerBounds = rangeOfRepresenationPart.lowerBound
            }
            
            //check if we have the word
            
            if userSentence.producer.lowercased().contains(representation.part.lowercased()) {
                
                
                
                //check the same range
                let stringRange = mostLikelyCorrect.stringRange(range: rangeOfRepresenationPart)
                let rangeInUserInput = equalPostion(stringToFind: representation.part, rangeOfString: stringRange, whereToFind: mutatingStr)
                
                
                //print (rangeOfRepresenationPart.lowerBound, mutatingStr.count)
                
                //print (representation.part, rangeInUserInput)
                
                if (rangeInUserInput == nil)
                {
                    //duplicate
                    if (mutatingStr.count > rangeOfRepresenationPart.lowerBound)
                    {
                        mutatingStr.insert(string: representation.part + " ", ind: rangeOfRepresenationPart.lowerBound)
                        
                    } else
                    {
                        mutatingStr = mutatingStr + " " + representation.part + " "
                    }
                    
                } else if (rangeInUserInput == NSMakeRange(0,0))
                {
                    
                    //the same range
                    //everything is good, range is the same
                    
                    
                } else if (rangeInUserInput != nil)
                {
                    //add
                    let r = Range(rangeInUserInput!, in: mutatingStr)
                    mutatingStr.removeSubrange(r!)
                    mutatingStr.insert(string: representation.part + " ", ind: rangeOfRepresenationPart.lowerBound)
                    result2[representationPart] = (rule?.description).flatMap { allRules[$0] }
                }
            } else
            {
                //add the word to the sentence
                
                if (mutatingStr.count > rangeOfRepresenationPart.lowerBound)
                {
                    mutatingStr.insert(string: representation.part + " ", ind: rangeOfRepresenationPart.lowerBound)
                    
                } else
                {
                    mutatingStr = mutatingStr + " " + representation.part + " "
                }
                
                result2[representationPart] = (rule?.description).flatMap { allRules[$0] }
            }
            mutatingStr = mutatingStr.condenseWhitespace()
            
            //mutatingStr.insert(string: regex.string, ind: 0)
        }
        
        
        
        let replacingCurrent = result.merging(result2) { (_, new) in new }
        
        return replacingCurrent
    }
    
    func findRange (stringToFind:String, lowerBounds:Int, whereToFind:String) -> NSRange {
        
        var pattern = "(?<=[^A-Za-z]|^)\(stringToFind)(?=[^A-Za-z]|$)"
        
        if (stringToFind == "?" || stringToFind == "!" || stringToFind == "." || stringToFind == "," || stringToFind == ", ") {
            pattern = "\\\(stringToFind)(?=[^A-Za-z]|$)"
        }
        
        let r = try! NSRegularExpression(pattern: pattern, options:.caseInsensitive)
        
        for match in r.matches(in: whereToFind, range: NSRange(lowerBounds..<whereToFind.utf16.count)) {
            
            return (match.range)
        }
        return NSMakeRange(0, 0)
    }
    
    //red in userinput
    func errorParts() -> [String.StringIndexRange] {
        
        var result: [String.StringIndexRange] = []
        let correctWords = mostLikelyCorrect.words
        
        
        for regex in userSentence.producer.find(regex: .englishWordRegex) {
            
            if !correctWords.contains(regex.string.lowercased()) {
                result.append(regex.range)
//            } else if (!) {
//                result.append(regex.range)
//            }
            }
        }
        return result
    }
    
    func userInputErrorsOrder() -> [String.StringIndexRange] {
        //samePosition()
        return inputErrors
    }
    
    func samePosition() -> [String.StringIndexRange] {
        
        var result: [String.StringIndexRange] = []
        
        if userSentence.producer == "" { return []}
        
        //remove all unnecessary words
        var mutatingStr = userSentence.producer
        
        var toDelete = [RegexResult]()
        
        //remove all wrong words
        for regex in mutatingStr.find(regex: .englishWordRegex) {
            
            if !mostLikelyCorrect.words.contains(regex.string.lowercased()) {
                toDelete.append(regex)
                //inputErrors.append(regex.range)
                //mutatingStr.removeSubrange(regex.range)
            }
        }
        
        
        
        if (toDelete.count != 0) {
            
            for index in (0..<toDelete.count).reversed() {
                mutatingStr.removeSubrange(toDelete[index].range)
            }
        }
        
        
        mutatingStr = mutatingStr.condenseWhitespace()
        mutatingStr = mutatingStr.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
        let mostLikelyWithoutCommas = mostLikelyCorrect.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        //print (mostLikelyWithoutCommas)
        
        
        //iterate mostlikelyCorrect.words
        for regex in mostLikelyWithoutCommas.find(regex: .englishWordRegex) {
            
            
            
            //check if we have the word
            if userSentence.producer.words.contains(regex.string.lowercased()) {
                
                //check the same range
                //let rangeInUserInput = equalPostion(regexToFind: regex, whereToFind: mutatingStr)
                
                let rangeInUserInput = equalPostion(stringToFind: regex.string.lowercased(), rangeOfString: regex.range, whereToFind: mutatingStr.lowercased())
                
                
                if (rangeInUserInput == nil)
                {
                    //duplicate
                    let stringRange = mostLikelyCorrect.nsRange(from: regex.range)
                    
                    if (mutatingStr.count > stringRange.lowerBound)
                    {
                        mutatingStr.insert(string: regex.string + " ", ind: stringRange.lowerBound)
                        
                    } else
                    {
                        mutatingStr = mutatingStr + " " + regex.string + " "
                    }
                    result.append(regex.range)
                    //inputErrors.append(regex.range)
                    
                } else if (rangeInUserInput == NSMakeRange(0,0))
                {
                    //the same range
                    
                } else
                {
                    
                    //add
                    let r = Range(rangeInUserInput!, in: mutatingStr)
                    mutatingStr.removeSubrange(r!)
                    
                    if let inputErrorRange = userSentence.producer.range(of: regex.string.lowercased()) {
                        
                        inputErrors.append(inputErrorRange)
                    }
                    
                    
                    let inx = mostLikelyCorrect.indexDistance(of: regex.string)
                    mutatingStr.insert(string: regex.string + " ", ind: inx!)
                    result.append(regex.range)
                    
                }
            } else
            {
                
                //add the word to the sentence
                let inx = mostLikelyCorrect.indexDistance(of: regex.string)
                
                if (mutatingStr.count > inx!)
                {
                    mutatingStr.insert(string: regex.string + " ", ind: inx!)
                    
                } else
                {
                    mutatingStr = mutatingStr + " " + regex.string + " "
                }
                
                result.append(regex.range)
            }
            mutatingStr = mutatingStr.condenseWhitespace()
            //mutatingStr.insert(string: regex.string, ind: 0)
        }
        
        //print (mutatingStr)
        //print (result)
        //print ("result", inputErrors)
        return result
    }
    
    func equalPostion (stringToFind:String, rangeOfString: Range<String.Index>, whereToFind:String) -> NSRange? {
        
        var pattern = "(?<=[^A-Za-z]|^)\(stringToFind)(?=[^A-Za-z]|$)"
        
        if (stringToFind == "?" || stringToFind == "!" || stringToFind == "." || stringToFind == "," || stringToFind == ", ") {
            pattern = "\\\(stringToFind)(?=[^A-Za-z]|$)"
        }
        
        
        
        let r = try! NSRegularExpression(pattern: pattern, options:.caseInsensitive)

        let nsRangeOfString = mostLikelyCorrect.nsRange(from: rangeOfString)
        
        
        if (nsRangeOfString.lowerBound > whereToFind.utf16.count) {return nil}
        
        for match in r.matches(in: whereToFind, range: NSRange(nsRangeOfString.lowerBound..<whereToFind.utf16.count)) {
            
            //print (nsRangeOfString, match.range)
            
            //let nr = mostLikelyCorrect.nsRange(from: rangeOfString)
            if (nsRangeOfString == match.range) {
                
                return NSMakeRange(0, 0)
                
            } else
            {
                
                return match.range
            }
        }
        
        return nil
    }
    
    
    //green in right sentence
    func correctedParts() -> [String.StringIndexRange] {
        var result: [String.StringIndexRange] = []
        let incorrectWords = userSentence.producer.words
        
        for regex in mostLikelyCorrect.find(regex: .englishWordRegex) {
            if !incorrectWords.contains(regex.string.lowercased()) {
                result.append(regex.range)
            }
        }
        
        
        return result
    }
    
    var allowedToCheck: Bool {
        var result = true
        
        let count = userSentence.producer.words.count
        if count == 0 || count < mostLikelyCorrect.words.count / 2 {
            result = false
        }
        
        return result
    }
    
    var isEnoughToShowCorrect: Bool {
        let result: Bool
        let correctWordsReduced = mostLikelyCorrect.reduceWords
        let userWordsReduced = userSentence.producer.reduceWords
        let userInputWords = userSentence.producer.words
        
        
        let correctUserWordsCount = userInputWords.reduce(0, { $0 + min(correctWordsReduced[$1, default: 0], userWordsReduced[$1, default: 0]) })
        result = Double(correctUserWordsCount) / Double(mostLikelyCorrect.wordsArray.count) > 0.3
        
        return result
    }
}

extension StringProtocol {
    func nsRange(from range: Range<Index>) -> NSRange {
        return .init(range, in: self)
    }
    
    func indexDistance<S: StringProtocol>(of string: S) -> Int? {
        guard let index = range(of: string)?.lowerBound else { return nil }
        return distance(from: startIndex, to: index)
    }
}

extension String {
    mutating func insert(string:String,ind:Int) {
        self.insert(contentsOf: string, at:self.index(self.startIndex, offsetBy: ind) )
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func rangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
        return Range(nsRange, in: self)
    }
    
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
