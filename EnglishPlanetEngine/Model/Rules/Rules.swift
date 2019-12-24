//
//  Rules.swift
//  EnglishPlanetEngine
//
//  Created by Serhiy Vysotskiy on 12/14/18.
//  Copyright © 2018 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

private class None {}
let rulesPath: String = {
    if let path = Bundle(for: None.self).path(forResource: "rules", ofType: "json") {
        return path
    } else {
        return FileManager.default.currentDirectoryPath + "/Model/Rules/rules.json"
    }
}()

private let rulesData = try! Data(contentsOf: URL(fileURLWithPath: rulesPath))
let allRules: Rules = try! JSONDecoder().decode(Rules.self, from: rulesData)

typealias Rules = [String: Rule]

public struct Rule: Codable {
    public let type: TypeEnum
    public let fields: Fields
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case fields = "fields"
    }
    
    public init(type: TypeEnum, fields: Fields) {
        self.type = type
        self.fields = fields
    }
}

public struct Fields: Codable {
    public let tense: String?
    public let form: Form?
    public let usage: String?
    public let marker: String?
    public let type: String?
    public let rule: RuleCase?
    public let futureForm: String?
    public let function: String?
    public let meaning: String?
    
    enum CodingKeys: String, CodingKey {
        case tense = "Tense"
        case form = "Form"
        case usage = "Usage"
        case marker = "Marker"
        case type = "Type"
        case rule = "Rule"
        case futureForm = "Future form"
        case function = "Function"
        case meaning = "Meaning"
    }
    
    public init(tense: String?, form: Form?, usage: String?, markers: String?, type: String?, rule: RuleCase?, futureForm: String?, function: String?, meaning:String?) {
        self.tense = tense
        self.form = form
        self.usage = usage
        self.marker = markers
        self.type = type
        self.rule = rule
        self.futureForm = futureForm
        self.function = function
        self.meaning = meaning
        
    }
}

public enum Form: Codable {
    case string(String)
    case stringArrayArray([[String]])
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([[String]].self) {
            self = .stringArrayArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Form.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Form"))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArrayArray(let x):
            try container.encode(x)
        }
    }
}

public enum RuleCase: String, Codable {
    case marker = "Marker"
    case modalVerbs = "Modal Verbs"
    case nonContinuousVerbs = "Non-continuous verbs"
    case theBareInfinitive = "The bare infinitive"
    case theGerund = "The gerund"
    case theToInfinitive = "The to + infinitive"
    case toBe = "To be"
    case prepositionOfPaceAt = "Preposition of place ‘at’"
    case prepositionOfPaceOn = "Preposition of place ‘on’"
    case prepositionOfPaceIn = "Preposition of place ‘in’"
    case prepositionOfTimeAt = "Preposition of time ‘at’"
    case prepositionOfTimeOn = "Preposition of time ‘on’"
    case prepositionOfTimeIn = "Preposition of time ‘in’"
    case prepositionTo = "Preposition ‘to’"
    case prepositionOn = "Preposition ‘on’"
    case prepositionIn = "Preposition ’in’"
    case prepositionAt = "Preposition ‘at’"
    case exception = "Exception"
    case noPrepositionTime = "No preposition of time"
    case getInInto = "Get in/into"
    case getOn = "Get on"
    case getOut = "Get out"
    case getOff = "Get off"
    case goBy = "Go /travel /fly + by + transport"
    case prepositionAbout = "Preposition ‘about’"
    case prepositionWith = "Preposition ‘with’"
    case prepositionFrom = "Preposition ‘from’"
    case lookAt = "Look + at"
    case lookFor = "Look + for"
    case lookForwardTo = "Look + forward to"
    case waitFor = "Wait + for"
    case listenTo = "Listen + to"
    case prepositionAfter = "Preposition ‘after’"
    case really = "Really"
    case very = "Very"
    case articleAAn = "Article ‘a/an’"
    case articleThe = "Article ‘the’"
    case zeroArticle = "Zero article"
    case superlativeForm = "Superlative form"
    case comparativeForm = "Comparative form"
    case imperative = "Imperative"
    case tagQuestion = "Tag question"
    case alternativeQuestion = "Alternative question"
    case specialQuestion = "Special question"
    case generalQuestion = "General question"
    case irregularAdjectives = "Irregular adjectives"
    case prepositionOf = "Preposition ‘of‘"
}

public enum TypeEnum: String, Codable {
    case conditional = "conditional"
    case tense = "tense"
}

