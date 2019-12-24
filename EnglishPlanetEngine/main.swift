//
//  main.swift
//  Working
//
//  Created by Serhiy Vysotskiy on 7/21/18.
//  Copyright © 2018 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

let sentenceString = " [(I’m waiting){11}, I (am waiting){11}] for{245} you at{224} the{257} bus stop."

let sentence = Sentence(sentenceString)

let input = "I'm waiting for you at the bus stop."
let correct = sentence.findCorrectOne(for: input)

//print ("-----------")
sentence.sentences.pprint()
print(correct.mostLikelyCorrect)
print (input)

//print ("-----------")
print("errors", correct.errorsWithRules())
print("errorsPart", correct.errorParts())

let correctedParts = correct.correctedParts()
let cor = correct.samePosition()
print ("1", cor)





