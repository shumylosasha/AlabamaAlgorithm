//
//  StringConstants.swift
//  Working
//
//  Created by Serhiy Vysotskiy on 7/28/18.
//  Copyright © 2018 Serhiy Vysotskiy. "

// MARK: - Regular expressions
extension String {
    static let bracketsRegex = "\\s+\\[.+?\\](?:\\{[0-9]+\\})*"
    //static let bracketsRegex = "\\[.+?\\](?:\\{[0-9]+\\})*"
    
    static let quotes = "‘’‘`''’"
    
    static let startEndPartRegex = "[>]+\\[.+?\\]"
    static let startEndPartRuledRegex = "[>]+\\[[a-zA-Z,\\s\(quotes)]+?\\]" + rulesRegex
    static let startEndPartEndingRegex = "[>]+<"
    static let startEndPartMoresRegex = "([>]+)\\["
    
    
    static let sentenceFirstLetterRegex = "\\. ."
    
    static let orderedWordRuledRegex = "[a-zA-Zа-яА-Я\(quotes)]+?[<]+\\{[0-9]*\\}"
    static let orderedWordRegex = "[a-zA-Zа-яА-Я\(quotes)]+?[<]+"
    static let orderedWordRuleRegex = "<[0-9{}]*"
    static let orderedWordMarkRegex = "([<]+)"
    
    static let rulesRegex = "\\{[0-9]+?\\}"
    static let rulesForWordRegex = "[a-zA-Zа-яА-Я\(quotes)]+?\\{[0-9]+?\\}"
    static let rulesForPhraseRegex = "\\(.+?\\)\\{[0-9]+?\\}"
    static let rulesForPhraseWordsRegex = "\\((.+?)\\)"
    static let rulesForBracketsRegex = "\\[[a-zA-Zа-яА-Я,\\s\(quotes){}0-9]+?\\]\\{[0-9]+?\\}"
    
    static let rulesForWordRemovedRegex = "[a-zA-Zа-яА-Я\(quotes)]+?"
    static let rulesForPhraseRemovedRegex = ".+?"
    static let rulesForBracketsRemovedRegex = "[a-zA-Zа-яА-Я,\\s\(quotes)]+?"
    
    static let englishWordRegex = "[a-zA-Z\(quotes)]+"
    //static let englishWordRegexWithPunctuation = "[a-zA-Z\(quotes)\(exclamationMark)\(questionMark)\(comma)\(dot)]+"
    static let optionalWordRegex = slash + englishWordRegex
    static let optionalWordWithRuleRegex = optionalWordRegex + rulesRegex
    static let numbersWordRegex = "[0-9\(quotes)]+(\\$?)"
    
    static let punctuationRegex = "[,.!?:;]"
    
    static let moreThan = ">"
    static let lessThan = "<"
    static let empty = ""
    static let exclamationMark = "!"
    static let questionMark = "?"
    static let dot = "."
    static let comma = ","
    static let column = ":"
    static let semicolumn = ";"
    static let doubleSpace = "  "
    static let space = " "
    static let slash = "/"
    static let backSlash = "\\"
    static let openingBracket = "["
    static let closingBracket = "]"
    static let openingCurlyBracket = "{"
    static let closingCurlyBracket = "}"
    static let openingBrace = "("
    static let closingBrace = ")"
}

var regex: String.Type {
    return String.self
}

let incorrectVerbs = [["be", "was", "were", "been"], ["beat", "beat", "beaten"], ["become", "became", "become"], ["begin", "began", "begun"], ["bend", "bent", "bent"], ["bet", "bet", "bet"], ["bite", "bit", "bitten"], ["bleed", "bled", "bled"], ["blow", "blew", "blown"], ["break", "broke", "broken"], ["breed", "bred", "bred"], ["bring", "brought", "brought"], ["build", "built", "built"], ["burn", "burnt", "burned", "burnt", "burned"], ["buy", "bought", "bought"], ["catch", "caught", "caught"], ["choose", "chose", "chosen"], ["come", "came", "come"], ["cost", "cost", "cost"], ["cut", "cut", "cut"], ["do", "did", "done"], ["dig", "dug", "dug"], ["draw", "drew", "drawn"], ["dream", "dreamt", "dreamed", "dreamt", "dreamed"], ["drink", "drank", "drunk"], ["drive", "drove", "driven"], ["eat", "ate", "eaten"], ["fall", "fell", "fallen"], ["feed", "fed", "fed"], ["feel", "felt", "felt"], ["fight", "fought", "fought"], ["find", "found", "found"], ["fly", "flew", "flown"], ["forget", "forgot", "forgotten"], ["forgive", "forgave", "forgiven"], ["freeze", "froze", "frozen"], ["get", "got", "got"], ["give", "gave", "given"], ["go", "went", "gone"], ["grow", "grew", "grown"], ["have", "had", "had"], ["hear", "heard", "heard"], ["hide", "hid", "hidden"], ["hit", "hit", "hit"], ["hold", "held", "held"], ["hurt", "hurt", "hurt"], ["keep", "kept", "kept"], ["know", "knew", "known"], ["lay", "laid", "laid"], ["lead", "led", "led"], ["lean", "leant", "leaned", "leant", "leaned"], ["leave", "left", "left"], ["lend", "lent", "lent"], ["let", "let", "let"], ["lose", "lost", "lost"], ["make", "made", "made"], ["mean", "meant", "meant"], ["meet", "met", "met"], ["pay", "paid", "paid"], ["put", "put", "put"], ["quit", "quit", "quit"], ["read", "read", "read"], ["ride", "rode", "ridden"], ["ring", "rang", "rung"], ["rise", "rose", "risen"], ["run", "ran", "run"], ["say", "said", "said"], ["see", "saw", "seen"], ["sell", "sold", "sold"], ["send", "sent", "sent"], ["set", "set", "set"], ["shake", "shook", "shaken"], ["shine", "shone", "shone"], ["shoe", "shod", "shod"], ["shoot", "shot", "shot"], ["show", "showed", "shown"], ["shrink", "shrank", "shrunk"], ["shut", "shut", "shut"], ["sing", "sang", "sung"], ["sink", "sank", "sunk"], ["sit", "sat", "sat"], ["sleep", "slept", "slept"], ["speak", "spoke", "spoken"], ["spend", "spent", "spent"], ["spill", "spilt", "spilled", "spilt", "spilled"], ["spread", "spread", "spread"], ["speed", "sped", "sped"], ["stand", "stood", "stood"], ["steal", "stole", "stolen"], ["stick", "stuck", "stuck"], ["sting", "stung", "stung"], ["stink", "stank", "stunk"], ["swear", "swore", "sworn"], ["sweep", "swept", "swept"], ["swim", "swam", "swum"], ["swing", "swung", "swung"], ["take", "took", "taken"], ["teach", "taught", "taught"], ["tear", "tore", "torn"], ["tell", "told", "told"], ["think", "thought", "thought"], ["throw", "threw", "thrown"], ["understand", "understood", "understood"], ["wake", "woke", "woken"], ["wear", "wore", "worn"], ["win", "won", "won"], ["write", "wrote", "written"]]

let incorrectVerbsDict = incorrectVerbs.reduce([String: [String]](), { $0.setting($1, for: $1) })
fileprivate extension Dictionary {
    func setting(_ value: Value?, for keys: [Key]) -> Dictionary {
        var dict = self
        
        keys.forEach { (key) in
            dict[key] = value
        }
        
        return dict
    }
}
