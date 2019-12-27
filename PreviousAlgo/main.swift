//
//  main.swift
//  Working
//
//  Created by Serhiy Vysotskiy on 7/21/18.
//  Copyright © 2018 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

let sentenceString = " [(I'm waiting){11}, I (am waiting){11}] for{245} you at{224} the{257} bus stop."

let sentence = Sentence(sentenceString)

let input = "I'm waiting for you at the bus stop."
let correct = sentence.findCorrectOne(for: input)


sentence.sentences.pprint()
print ("-----------")
print ("userInput", input)
print ("mostLikelyCorrect", correct.mostLikelyCorrect)


print ("-----------")
print("errorsWithRules", correct.errorsWithRules())
print("errorsNoRules", correct.errorParts())

let correctedParts = correct.correctedParts()
let samePosition = correct.samePosition()
print ("orderErrors", samePosition)
