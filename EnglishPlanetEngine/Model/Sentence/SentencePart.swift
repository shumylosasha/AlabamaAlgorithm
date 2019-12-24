//
//  SentencePart.swift
//  EnglishPlanetEngine
//
//  Created by Serhiy Vysotskiy on 2/26/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

/// SentencePart
// MARK: - SentencePart
public class SentencePart {
    public let mother: String
    public let range: String.StringIndexRange
    public let part: String
    public let rule: Int?
    
    public class var pattern: String {
        return regex.empty
    }
    
    public required init(mother: String, range: String.StringIndexRange, part: String, rule: Int?) {
        self.mother = mother
        self.range = range
        self.part = part
        self.rule = rule
    }
    
    public var representations: [RepresentationPart] {
        //print ("RepresentationPart.pattern", RepresentationPart.pattern)
        
        return re.finditer(RepresentationPart.pattern, part).map { word in
            RepresentationPart(parent: self, range: word.matchStringRange, part: word.matchString)
        }
    }
}

class NumberPart: SentencePart {
    
    override class var pattern: String {
        return regex.numbersWordRegex
    }
    
    override var representations: [RepresentationPart] {
        return [RepresentationPart(parent: self, range: range, part: part)]
    }
}


public class RepresentationPart: WordPart {
    public weak var parent: SentencePart?
    
    public override class var pattern: String {
        return regex.englishWordRegex
    }
    
    convenience init(parent: SentencePart, range: String.StringIndexRange, part: String) {
        self.init(mother: parent.part, range: range, part: part, rule: parent.rule)
        self.parent = parent
    }
    
    public override var representations: [RepresentationPart] {
        return []
    }
}

class EmptyRepresentationPart: RepresentationPart {
    convenience init(parent: SentencePart) {
        self.init(parent: parent, range: parent.part.stringRange(range: NSRange()), part: .empty)
    }
}

class MultiPartRepresentationPart: RepresentationPart {
    var parts = [SentencePart]()
    
}

class MultivariantPart: SentencePart {
    override class var pattern: String {
        .bracketsRegex
    }
    
    override var representations: [RepresentationPart] {
        return getRepresentations()
    }
    
    func getRepresentations() -> [RepresentationPart] {
        var result = [RepresentationPart]()
        
        part.removingEndRule().removingBrackets().getCommaSeparated().forEach { (commaSeparatedWord) in
            let rule = commaSeparatedWord.hasRule ? commaSeparatedWord.getRule() : self.rule
            
            // optional case
            if commaSeparatedWord.starts(with: regex.slash) {
                let parts = [String(commaSeparatedWord.dropFirst()), String()].map {
                    RepresentationPart(mother: mother, range: range, part: $0.removingRules(), rule: rule)
                }
                
                result.append(contentsOf: parts)
                return
            }
            
            let representation = RepresentationPart(mother: mother, range: range, part: commaSeparatedWord.removingRules(), rule: rule)
            result.append(representation)
        }
        
        return result
    }
}

//class RuledMultivariantPart: MultivariantPart {
//    override class var pattern: String {
//        return regex.rulesForBracketsRegex
//    }
//    
//    override var representations: [RepresentationPart] {
//        return part.removingBrackets().removingRules().getCommaSeparated().map { RepresentationPart(parent: self, range: range, part: $0) }
//    }
//}

public class WordPart: SentencePart {
    public override class var pattern: String {
        return regex.englishWordRegex
    }
}

class OptionalWordPart: WordPart {
    override class var pattern: String {
        regex.optionalWordRegex
    }
    
    override var representations: [RepresentationPart] {
        return [String(part.dropFirst()), String()].map { RepresentationPart(parent: self, range: range, part: $0) }
    }
}



class RuledWordPart: WordPart {
    override class var pattern: String {
        return regex.rulesForWordRegex
    }
}

class OrderedPart: SentencePart {
    var count: Int = 0
    var orderedParts: [SentencePart] = []
    var orderedVariants: [String] {
        let words = [representations.map(\.part)] + orderedParts.map { $0.representations.map(\.part) }
        let product = CartesianProduct(words)
        return product.reduce([String](), { $0 + [$1.joined(separator: .space)] })
    }
    
    override class var pattern: String {
        return regex.orderedWordRegex
    }
}

class RuledOptionalWordPart : WordPart {
    override class var pattern: String {
        regex.optionalWordWithRuleRegex
    }
    
    override var representations: [RepresentationPart] {
        [String(part.dropFirst()), String()].map { RepresentationPart(mother: mother, range: range, part: $0.removingRules(), rule: rule) }
    }
}

class RuledOrderedPart: OrderedPart {
    override class var pattern: String {
        return regex.orderedWordRuledRegex
    }
}

class StartEndPart: SentencePart {
    weak var endPart: EndPart?
    
    override class var pattern: String {
        return regex.startEndPartRegex
    }
    
    override var representations: [RepresentationPart] {
        let repr: [RepresentationPart] = part.removingStartEndBrackets().getCommaSeparated().map {
            let rule = $0.hasRule ? $0.getRule() : self.rule
            
            return RepresentationPart(mother: mother, range: range, part: $0.removingRules(), rule: rule)
        }
        
        return repr + (0..<repr.count).map { _ in EmptyRepresentationPart(parent: self) }
    }
}

class RuledStartEndPart: StartEndPart {
    override class var pattern: String {
        return regex.startEndPartRuledRegex
    }
}

class EndPart: SentencePart {
    weak var startPart: StartEndPart?
    
    override class var pattern: String {
        return regex.startEndPartEndingRegex
    }
    
    override var representations: [RepresentationPart] {
        return startPart?.representations ?? []
    }
}

class PunctuationPart: SentencePart {
    override class var pattern: String {
        return regex.punctuationRegex
    }
    
    override var representations: [RepresentationPart] {
        return [RepresentationPart(parent: self, range: range, part: part)]
    }
}

class GroupPart: SentencePart {
    override class var pattern: String {
        return regex.rulesForPhraseRegex
    }
    
    override var representations: [RepresentationPart] {
        guard let found = re.finditer(regex.rulesForPhraseWordsRegex, part).first?.group(1) else { return [] }
        return [RepresentationPart(parent: self, range: range, part: found)]
    }
}
