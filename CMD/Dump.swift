//
//  Dump.swift
//  CMD
//
//  Created by Serge Vysotsky on 29.09.2019.
//  Copyright © 2019 Serge Vysotsky. All rights reserved.
//

import Foundation

/*
 func findBracketsSubsequences(_ sentence: String.SubSequence) -> [Int: [String.SubSequence]] {
     var subsequences = [Int: [String.SubSequence]]()
     var startIndices = [Int: String.Index]()
     var pairsCount = 0
     
     for index in sentence.indices {
         let char = sentence[index]
         if char == "[" {
             startIndices[pairsCount] = index
             pairsCount += 1
         }
         
         if char == "]" {
             pairsCount -= 1
             subsequences[pairsCount, default: []].append(sentence[startIndices.removeValue(forKey: pairsCount)!...index])
         }
     }

     return subsequences
 }

 indirect enum Sentence {
     typealias SentencePart = Sentence
     
     case sentence([SentencePart])
     case brackets([SentencePart], rule: Int?)
     case startEnd([SentencePart], afterPart: SentencePart, rule: Int?)
     
     case punctuation(Substring)
     case group(Substring, rule: Int?)
     case word(Substring, rule: Int?)
     
     case before([SentencePart], before: SentencePart, rule: Int)
 }

 
 
func getTopSentencePart(_ sentence: String) -> [String.SubSequence] {
    var result = [String.SubSequence]()
    
    let sequence = sentence[sentence.startIndex...]
    if let topBracketsSequences = findBracketsSubsequences(sequence)[0]?.sorted(for: \.startIndex, by: <) {
        if !topBracketsSequences.isEmpty {
            result.append(sequence[sequence.startIndex..<topBracketsSequences.first!.startIndex])
            
            for (i, sequence) in topBracketsSequences.enumerated() where i < topBracketsSequences.count - 1 {
                let range = sequence.endIndex...topBracketsSequences[i + 1].startIndex
                let sub = sequence.base[range]
                result.append(sub)
            }
            
            result.append(sequence[topBracketsSequences.last!.endIndex...])
        }
    }
    
    return result
}

extension Sentence {
    init(sentence: String) {
        self = .sentence(getTopSentencePart(sentence).map { Sentence($0) })
    }
    
    private init(_ part: String.SubSequence) {
        if let sequences = findBracketsSubsequences(part)[0] {
            self = .brackets(sequences.map({ $0.dropFirst().dropLast() }).map { Sentence($0) })
        } else if part.contains(",") {
            self = .commaSeparated(part.parts(separatedBy: ",").map { $0.trimming(.whitespaces) }.map { Sentence($0) })
        } else {
            self = .word(Word(subsequence: part))
        }
    }
}

let sentence = Sentence(sentence: string)
print(sentence)

*/
