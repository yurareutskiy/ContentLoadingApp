//
//  CommentsView.swift
//  ContentLoadingApp
//
//  Created by Yura Reutskiy on 18/11/2022.
//

import SwiftUI

struct CommentsView: View {
    
    @State var isLoading: Bool = false
    @State private var showingErrorAlert = false
    @State private var showingErrorText = ""
    
    @EnvironmentObject var commentService: CommentService
        
    let taskStorage = TaskStorage()
    class TaskStorage {
        var task: Task<(),Never>?
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemCyan).opacity(0.2).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    LoadButton(condition: $isLoading) {
                        if isLoading {
                            reset()
                        } else {
                            startLoading()
                        }
                    }
                    Spacer()
                    List(commentService.list, id: \.id) { item in
                        VStack(alignment: .leading) {
                            Text(item.displayContent)
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert($showingErrorText.wrappedValue, isPresented: $showingErrorAlert) {
                Button("OK", role: .cancel) { }
            }
            .navigationTitle("Comments")
        }
        
    }
    
    func reset() {
        taskStorage.task?.cancel()
        taskStorage.task = nil
        isLoading = false
    }
    
    func startLoading() {
        isLoading = true
        taskStorage.task = Task {
            defer {
                Task { @MainActor in
                    reset()
                }
            }
            do {
                try await commentService.srartLoading()
            } catch {
                showingErrorText = error.localizedDescription
                showingErrorAlert = true
            }
            
        }
    }
}
