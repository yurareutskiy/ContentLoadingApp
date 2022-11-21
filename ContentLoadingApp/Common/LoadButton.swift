//
//  LoadButton.swift
//  ContentLoadingApp
//
//  Created by Yura Reutskiy on 18/11/2022.
//

import SwiftUI

struct LoadButton: View {
    @Binding var condition: Bool
    
    let action: (() -> Void)
    
    var body: some View {
        HStack {
            Button(condition ? "Stop" : "Start") {
                action()
            }
            .buttonStyle(.bordered)
            .foregroundColor(condition ? Color.red : Color.blue)
        }
        .padding()
    }
}
