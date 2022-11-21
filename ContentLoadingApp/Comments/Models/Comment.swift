//
//  Comment.swift
//  ContentLoadingApp
//
//  Created by Yura Reutskiy on 18/11/2022.
//

import Foundation


struct Comment: Codable, Identifiable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
    
    var displayContent: String {
//        "\(name): \(String(body.prefix(70)))"
        "\(email.lowercased()): \(name)"
    }
}

