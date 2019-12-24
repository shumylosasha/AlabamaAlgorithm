//
//  NumericExtensions.swift
//  Working
//
//  Created by Serhiy Vysotskiy on 10/15/18.
//  Copyright © 2018 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

extension Int {
    var incremented: Int {
        return self + 1
    }
    
    var decremented: Int {
        return self - 1
    }
}

extension Int {
    @inlinable public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Int) throws -> Result) rethrows -> Result {
        return try (0..<self).reduce(initialResult, nextPartialResult)
    }
}
