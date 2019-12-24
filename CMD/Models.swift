//
//  Models.swift
//  CMD
//
//  Created by Serge Vysotsky on 06.10.2019.
//  Copyright © 2019 Serge Vysotsky. All rights reserved.
//

import Foundation

protocol SentencePart {
    var substring: Substring { get }
}

protocol RuledSentencePart: SentencePart {
    var rule: Rule? { get }
}

protocol EmbedderSentencePart: SentencePart {
    var children: [SentencePart] { get }
}

struct StartEnd: EmbedderSentencePart, RuledSentencePart {
    let substring: Substring
    let endpoing: Range<String.Index>
    let rule: Rule?
    let children: [SentencePart]
}

struct Brackets: EmbedderSentencePart, RuledSentencePart {
    let substring: Substring
    let rule: Rule?
    let children: [SentencePart]
}

struct Group: RuledSentencePart {
    let substring: Substring
    let rule: Rule?
}

struct Word: RuledSentencePart {
    let substring: Substring
    let rule: Rule?
}

struct Comma: SentencePart {
    let substring: Substring
}

struct Rule: SentencePart {
    let substring: Substring
    var rule: Int {
        Int(substring.dropFirst().dropLast())!
    }
}
