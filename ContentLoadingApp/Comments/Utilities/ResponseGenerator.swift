//
//  ResponseGenerator.swift
//  ContentLoadingApp
//
//  Created by Yura Reutskiy on 18/11/2022.
//

import Foundation

struct ResponseGenerator: AsyncSequence, AsyncIteratorProtocol {
    typealias Element = [Comment]
    var current = 1
    let limit = 10
    var delayInSeconds = 1
    let networkService: NetworkService

    mutating func next() async throws -> Element? {
        guard current <= limit else { return nil }
        try await Task.sleep(nanoseconds: UInt64(delayInSeconds) * 1_000_000_000)
        if Task.isCancelled {
            return nil
        }
        print(current)
        let response = try await networkService.load(page: current)
        current += 1
        return response
    }

    func makeAsyncIterator() -> ResponseGenerator {
        self
    }
}
