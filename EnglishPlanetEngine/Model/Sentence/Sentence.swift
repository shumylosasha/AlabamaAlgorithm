//
//  Sentence.swift
//  EnglishPlanetEngine
//
//  Created by Serhiy Vysotskiy on 1/5/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

// MARK: - Sentence
public class Sentence {
    public let producer: String
    public let parts: [SentencePart]
    public var variants: [String: [RepresentationPart]] = [:]
    public let allPossibleParts: [[SentencePart]]
    
    public lazy var sentences = generateSentences()
    
    public init(_ producer: String) {
        self.producer = producer
        allPossibleParts = Sentence.parse(producer)
        //print (allPossibleParts)
        parts = allPossibleParts[0]
        
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

extension Sentence {
    private func generateSentences() -> [String] {
        var result = [String]()
        
        
        for partsOfOneSentence in allPossibleParts {
            
            
            let pairsIndexes: [(start: Int, end: Int)] = partsOfOneSentence.enumerated().filter({ $0.element is StartEndPart }).compactMap { startIndex, start in
                 if let endIndex = partsOfOneSentence.enumerated().first(where: { ($0.element as? EndPart)?.startPart === start })?.offset {
                     return (startIndex, endIndex)
                 }
                 
                 return nil
             }
            
             
            let product = CartesianProduct(partsOfOneSentence.map(\.representations))
            
             outer: for variant in product {
                
                 for (start, end) in pairsIndexes {
                     if type(of: variant[start]) == type(of: variant[end]) {
                        
                        continue outer
                     }
                 }
                 
                 
                 let str = variant.map({ $0.part }).joined(separator: .space).cleared().uppercasedFirst
                result.append(str)
                variants[str] = variant
             }
            
        }
        
        result.removeDuplicates()
        
        
        
        return result.filterRepeating()
}
    
    
    private static func parse(_ sentence: String) -> [[SentencePart]] {
        let parsers: [SentencePart.Type] = [
            
            MultivariantPart.self,
            
            GroupPart.self,
            RuledStartEndPart.self,
            StartEndPart.self,
            
            
//            RuledMultivariantPart.self,
            
            RuledOrderedPart.self,
            OrderedPart.self,
            
            RuledOptionalWordPart.self,
            OptionalWordPart.self,
            
            
            RuledWordPart.self,
            WordPart.self,
            NumberPart.self,
            PunctuationPart.self,
            
        ]
        
        var s = sentence
        var result = [[SentencePart]]()
        result.append([SentencePart]())
        
        
        
        
        outer: for parser in parsers {
            let parts = re.finditer(parser.pattern, s)
            //let checkParts = re.finditer(StartEndPart.pattern, s)
            
            
            
            for p in parts {

                let matchRange = p.match.range
                let replace = String(Range(matchRange)!.map { _ in Character("-") })
                let range = s.stringRange(range: matchRange)
                //print (matchRange)
                let string = String(s[range])
                
                var rule: Int?
                if string.hasRule {
                    let ruleNumber = string.getRule()
                    let ruleString = "{\(ruleNumber)}"
                    rule = string.ends(with: ruleString) ? ruleNumber : nil
                }
                
                s.replaceSubrange(range, with: replace)
                
                let part = parser.init(mother: sentence, range: range, part: string, rule: rule)
                //print (part.part)
                
                if part is MultivariantPart {
                    
                   let recursionSentence = String(string.dropFirst().dropLast())
                    
                   let splitRecursion = recursionSentence.split(separator: ",")
                   //print (splitRecursion)
                   
                    splitRecursion.forEach({ element in
                       
                        var newMotherSentence = part.mother
                        newMotherSentence.replaceSubrange(part.range, with: element)
                        
                        let newMotherSentenceParts = self.parse(newMotherSentence)
                        newMotherSentenceParts.forEach({element in
                            result.append(element)
                        })
                    })
                    
                    break outer
                    
                } else if part is StartEndPart
                {
                    
                    result[0].append(part)
                    
                    if let startPart = part as? StartEndPart {
                        
                        if let indicatorString = re.finditer(regex.startEndPartMoresRegex, startPart.part).first?.group(1) {
                            
                            let endPartRegex = indicatorString + .lessThan
                            
                            if let endMatch = re.finditer(endPartRegex, s).first(where: { match in
                                let pre = String(s[s.index(before: match.matchStringRange.lowerBound)])
                                return (pre == " " || pre == "")
                            }) {
                                let endRange = s.stringRange(range: endMatch.match.range)
                                let endString = String(s[endRange])
                                let endPart = EndPart(mother: sentence, range: endRange, part: endString, rule: nil)
                                
                                
                                let endReplace = String(Range(endMatch.match.range)!.map { _ in Character("-") })
                                s.replaceSubrange(endRange, with: endReplace)
                                
                                result[0].append(endPart)
                                
                                startPart.endPart = endPart
                                endPart.startPart = startPart
                            }
                        }
                    }
                    
                    
                } else
                {
                    result[0].append(part)
                }
                
                if let ordered = part as? OrderedPart {
                    if let indicatorString = re.finditer(regex.orderedWordMarkRegex, ordered.part).first?.group(1) {
                        ordered.count = indicatorString.count
                    }
                }
            }
        }
        
        
        result[0].sort(keyPath: \SentencePart.range.lowerBound, by: <)
        
        for i in 0..<result[0].count {
            if let ordered = result[0][i] as? OrderedPart {
                ordered.orderedParts = Array(result[0][(i + 1)...(i + ordered.count)])
                result[0][i] = ordered
            }
        }
        
        return result
    }
}

extension re.MatchObject {
    var matchString: String {
        return String(string[string.stringRange(range: match.range)])
    }
    
    var matchStringRange: String.StringIndexRange {
        //let d = string.nsRange(from: match.range)
        return string.stringRange(range: match.range)
    }
}

extension Sentence {
    /// Finds most correct sentence
    ///
    /// - Parameter userSentence: User input sentence
    /// - Returns: Correct sentence that corresponds the most to the user input
    public func findCorrectOne(for userSentence: String) -> Correct {
        let userSentence = userSentence.withAllowedQuotationMark
        let shouldContainWords = generateShouldContainWords(userSentence: userSentence)
        
        let correctNew = sentences.max { (s1, s2) -> Bool in
            return compare(s1, s2, transforms: [
                buildTransformer(transform: {
                    $0.lowercased().removingPunctuation.stripped() == userSentence.lowercased().removingPunctuation.stripped() ? 9999 : 0
                }, compare: <),
                buildTransformer(transform: { $0.intersection(userSentence) }, compare: <),
                buildTransformer(transform: { $0.countSameWords(userSentence) }, compare: <),
                buildTransformer(transform: { $0.words.intersection(shouldContainWords.union(userSentence.words)).count }, compare: <),
                buildTransformer(transform: { $0.compareAgainstStartEndWords(userSentence) }, compare: <),
            ], comparer: >)
        }
        
        precondition(correctNew != nil)
        return Correct(sentence: self, mostLikelyCorrect: correctNew!, userSentence: userSentence)
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
extension Sentence {
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

