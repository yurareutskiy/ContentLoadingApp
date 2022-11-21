//
//  CommentService.swift
//  ContentLoadingApp
//
//  Created by Yura Reutskiy on 18/11/2022.
//

import Foundation

enum CommentServiceError: Error {
    case timeout
    case unknown
}

class CommentService: ObservableObject {
    let networkService = NetworkService()

    @Published var list: [Comment] = []
    
    let timeout: UInt64 = 10 * 1_000_000_000
    
    func srartLoading() async throws {
        return try await waitForTaskCompletion(withTimeoutInNanoseconds: timeout) { [weak self] in
            guard let self = self else { throw CommentServiceError.unknown }
            let sequence = ResponseGenerator(delayInSeconds: 1, networkService: self.networkService)
            for try await response in sequence {
                Task { @MainActor in self.list.append(contentsOf: response) }
            }
        }
    }
    
    public func waitForTaskCompletion<R>(
        withTimeoutInNanoseconds timeout: UInt64,
        _ task: @escaping () async throws -> R
    ) async throws -> R {
        return try await withThrowingTaskGroup(of: R.self) { group in
            group.addTask {
                return try await task()
            }
            group.addTask {
                await Task.yield()
                try await Task.sleep(nanoseconds: timeout)
                print("TIMEOUT")
                throw CommentServiceError.timeout
            }
            defer { group.cancelAll() }
            return try await group.next()!
        }
    }
}
