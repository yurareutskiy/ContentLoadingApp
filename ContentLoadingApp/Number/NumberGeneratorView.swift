//
//  NumberGeneratorView.swift
//  ContentLoadingApp
//
//  Created by Yura Reutskiy on 18/11/2022.
//

import SwiftUI


struct NumberGeneratorView: View {
    
    
    @State private var isLoading: Bool = false
    @State private var showingErrorAlert = false
    @State private var showingErrorText = ""
    
    
    @State private var list: [Int] = []
    
    private class TaskStorage {
        var task: Task<(),Never>?
    }
    private let taskStorage = TaskStorage()
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.orange).opacity(0.2).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    LoadButton(condition: $isLoading, action: startLoading)
                    Spacer()
                    List(list, id: \.self) { item in
                        VStack(alignment: .leading) {
                            Text("item: \(item)")
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert($showingErrorText.wrappedValue, isPresented: $showingErrorAlert) {
                Button("OK", role: .cancel) { }
            }
            .navigationTitle("Numbers")
        }
        
    }
    
    func startLoading() {
        
        if isLoading {
            isLoading = false
            self.taskStorage.task?.cancel()
            self.taskStorage.task = nil
        } else {
            isLoading = true
            self.taskStorage.task = Task {
                let sequence = DoubleGenerator()

                for await number in sequence {
                    print(number)
                    Task { @MainActor in list.append(number) }
                }
            }
        }
    }
}

