//
//  DoubleGenerator.swift
//  ContentLoadingApp
//
//  Created by Yura Reutskiy on 18/11/2022.
//

import Foundation

struct DoubleGenerator: AsyncSequence, AsyncIteratorProtocol {
    typealias Element = Int
    var current = 1

    mutating func next() async -> Element? {
        
        let delay = 1
        try? await Task.sleep(nanoseconds: UInt64(delay) * 1_000_000_000)
        if Task.isCancelled {
            return nil
        }
        defer { current &*= 2 }

        if current < 0 {
            return nil
        } else {
            return current
        }
    }

    func makeAsyncIterator() -> DoubleGenerator {
        self
    }
}
