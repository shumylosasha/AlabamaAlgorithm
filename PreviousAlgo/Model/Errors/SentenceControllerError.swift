//
//  SentenceControllerError.swift
//  EnglishPlanetEngine
//
//  Created by Serhiy Vysotskiy on 10/17/18.
//  Copyright © 2018 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

enum SentenceControllerError: LocalizedError {
    case wrongStartEndPattern
    
    var errorDescription: String? {
        switch self {
        case .wrongStartEndPattern:
            return "Wrong start end pattern >[...] ... >."
        }
    }
}
