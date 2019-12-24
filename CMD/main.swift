//
//  main.swift
//  CMD
//
//  Created by Serge Vysotsky on 10.08.2019.
//  Copyright © 2019 Serge Vysotsky. All rights reserved.
//

import Foundation

private let sentence = ">[Today, Now], [Hello, Hi, darling{1}, (darling babe){15}, (darling wow){17} yeah]{12}, nice to see you<{13} [back, again] ><."
//let parts = string[string.startIndex...].parseSentence()
//print(parts)

enum SyntaxElement: Character {
    case bracketOpen = "["
    case bracketClose = "]"
    
    case braceOpen = "("
    case braceClose = ")"
    
    case startEnd = ">"
    case startEndClose = "<"
    
    case ruleOpen = "{"
    case ruleClose = "}"
    
    case comma = ","
    case whitespace = " "
}

enum RawStringCase {
    case word
    case ruledWord
    case group
    case ruledGroup
    
    case orderRuledWord
    
    init(_ rawString: String) {
        switch rawString {
        case let word where word.allCharacters(.contained(.wordCharacterSet), .containsNot(.rules)):
            self = .word
        case let word where word.allCharacters(.contained(.ruledWordCharacterSet), .contains(.rules)):
            self = .ruledWord
        case let group where group.allCharacters(.contained(.ruledGroupCharacterSet), .containsNot(.rules)):
            self = .group
        case let group where group.allCharacters(.contained(.ruledGroupCharacterSet), .contains(.rules)):
            self = .ruledGroup
        case let ordered where ordered.allCharacters(.containsNot(.whitespaces), .contains(.set(.startEndClose))):
            self = .orderRuledWord
        default:
            fatalError("UNHANDLED CASE DETECTED –– \(rawString)")
        }
    }
}

extension CharacterSet {
    func union(_ sets: CharacterSet...) -> CharacterSet {
        return sets.reduce(self, { $0.union($1) })
    }
    
    static func union(_ sets: CharacterSet...) -> CharacterSet {
        return sets.reduce(CharacterSet(), { $0.union($1) })
    }
    
    static func set(_ fromSyntax: SyntaxElement...) -> CharacterSet {
        return CharacterSet(charactersIn: fromSyntax.map(\.rawValue).map(String.init).reduce(String(), +))
    }
    
    static let wordCharacterSet = CharacterSet.alphanumerics
    
    static let rules = CharacterSet.set(.ruleOpen, .ruleClose)
    static let braces = CharacterSet.set(.braceOpen, .braceClose)
    
    static let ruledWordCharacterSet = wordCharacterSet.union(.rules)
    static let ruledGroupCharacterSet = wordCharacterSet.union(.whitespaces, .braces, .rules)
    
    static let orderedRuledWord = ruledWordCharacterSet.union(.set(.startEndClose))
    
}

extension String {
    func substring(index workingIndex: inout Index, reaching finalCharacter: SyntaxElement) -> String {
        var result = ""
        var workingCharacter = self[workingIndex]
        
        while workingIndex != endIndex && workingCharacter != finalCharacter.rawValue {
            result.append(workingCharacter)
            workingIndex = index(after: workingIndex)
            workingCharacter = self[workingIndex]
        }
        
        return result
    }
}

extension String {
    @inline(__always) func allCharacters(in set: CharacterSet) -> Bool {
        return allSatisfy { $0.unicodeScalars.allSatisfy { set.contains($0) } }
    }
    
    @inline(__always) func containsCharacters(in set: CharacterSet) -> Bool {
        return contains { $0.unicodeScalars.allSatisfy { set.contains($0) } }
    }
    
    @inline(__always) func allCharacters(containedIn set: CharacterSet, andContainsSubset subset: CharacterSet) -> Bool {
        return allCharacters(in: set) && containsCharacters(in: subset)
    }
    
    @inline(__always) func allCharacters(containedIn set: CharacterSet, andContainsSubsetNot subset: CharacterSet) -> Bool {
        return allCharacters(in: set) && !containsCharacters(in: subset)
    }
    
    enum Descriptor {
        case contains(CharacterSet)
        case contained(CharacterSet)
        case containsNot(CharacterSet)
        case containedNot(CharacterSet)
        
        func evaluate(_ string: String) -> Bool {
            switch self {
            case let .contains(set):
                return string.containsCharacters(in: set)
            case let .contained(set):
                return string.allCharacters(in: set)
            case let .containsNot(set):
                return !string.containsCharacters(in: set)
            case let .containedNot(set):
                return string.allSatisfy { $0.unicodeScalars.allSatisfy { !set.contains($0) } }
            }
        }
    }
    
    @inline(__always) func allCharacters(_ satisfyDescriptors: Descriptor...) -> Bool {
        return satisfyDescriptors.reduce(true, { $0 && $1.evaluate(self) })
    }
    
    func parse() {
        var workingIndex = startIndex
        @inline(__always) func incrementIndex() {
            workingIndex = index(after: workingIndex)
        }

        while workingIndex != endIndex {
            let character = self[workingIndex]
            
            if let syntax = SyntaxElement(rawValue: character) {
                switch syntax {
                case .bracketOpen:
                    incrementIndex()
                    let content = substring(index: &workingIndex, reaching: .bracketClose)
                    let subsentences = content.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                    print(subsentences)
                    
                    subsentences.forEach { subsentence in
                        subsentence.parse()
                        
                        subsentence.components(separatedBy: .whitespaces).forEach { word in
                            let wordCase = RawStringCase(word)
                            print("\(word) –– \(wordCase)")
                        }
                    }
                default:
                    break
                }
            }
            
            incrementIndex()
        }
    }
}

let sentenceString = "[some coffee{263}, a<{250} cup of coffee, (group goes here){2}]{1} asd<{123} DDA"
sentenceString.parse()

