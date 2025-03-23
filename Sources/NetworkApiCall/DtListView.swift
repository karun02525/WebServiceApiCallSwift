//
//  Test.swift
//  NetworkApiCall
//
//  Created by Kumar, Karun (893) (EXT) on 23/03/25.
//

import SwiftUI

public struct Todo: Identifiable {
    public let id: Int
    public let title: String
    public let completed: Bool
    
    public init(id: Int, title: String, completed: Bool) {
        self.id = id
        self.title = title
        self.completed = completed
    }
}

public class TodoViewModel: ObservableObject {
    @Published public var todos: [Todo] = []
    
    
    public init() {}
    
    public func fetchTodos() {
        // Simulate fetching data
        self.todos = [
            Todo(id: 1, title: "Buy groceries", completed: false),
            Todo(id: 2, title: "Walk the dog", completed: true),
            Todo(id: 3, title: "Finish homework", completed: false),
            Todo(id: 4, title: "Buy groceries", completed: false),
            Todo(id: 5, title: "Walk the dog", completed: true),
            Todo(id: 6, title: "Finish homework", completed: false),
            Todo(id: 7, title: "Buy groceries", completed: false),
            Todo(id: 8, title: "Walk the dog", completed: true),
            Todo(id: 9, title: "Finish homework", completed: false),
            Todo(id: 10, title: "Finish homework", completed: false),
            Todo(id: 11, title: "Buy groceries", completed: false),
            Todo(id: 12, title: "Walk the dog", completed: true),
            Todo(id: 13, title: "Finish homework", completed: false),
            Todo(id: 14, title: "Walk the dog", completed: true),
            Todo(id: 15, title: "Buy groceries", completed: false),
           
            // Add more items as needed
        ]
    }
}

public struct DTICICLISTView: View {
    @StateObject private var viewModel = TodoViewModel()
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.todos) { todo in
                        VStack(alignment: .leading) {
                            Text(todo.title)
                                .font(.headline)
                            Text(todo.completed ? "Completed" : "Not Completed")
                                .font(.subheadline)
                                .foregroundColor(todo.completed ? .green : .red)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading) // Fill the width
                        .padding()
                        .background(Color(.systemBackground)) // Add a background for better visibility
                        .cornerRadius(8)
                        .shadow(radius: 2) // Optional: Add a shadow for better card appearance
                        .onTapGesture {
                            // Handle tap on the card
                            print("Tapped on: \(todo.title)")
                        }
                    }
                }
                .padding(.horizontal) // Add horizontal padding to the LazyVStack
            }
            .onAppear {
                viewModel.fetchTodos()
            }
            .navigationTitle("Todos")
        }
    }
}

#Preview {
    DTICICLISTView()
}
