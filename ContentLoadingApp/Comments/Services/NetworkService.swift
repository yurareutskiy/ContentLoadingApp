//
//  NetworkService.swift
//  ContentLoadingApp
//
//  Created by Yura Reutskiy on 18/11/2022.
//

import Foundation

enum APIError: Error {
    case urlError
    case noContent
}

class NetworkService {
    
    func load(page: Int = 1) async throws -> [Comment] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(page)/comments") else {
            print("Your API end point is Invalid")
            throw APIError.urlError
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let commentList = try JSONDecoder().decode([Comment].self, from: data)
        if commentList.isEmpty {
            throw APIError.noContent
        }
        return commentList
    }
    
}
