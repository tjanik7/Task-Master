//
//  ContentView.swift
//  Task Master
//
//  Created by Ty Janik on 5/2/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var path = [String]()
    
    //    @Query private var tasks: [Task] // TODO: Implement storage
    @State private var tasks: [Task] = []

    @State private var showForm = false

    var body: some View {
        NavigationStack {
            List(tasks, id: \.self) { task in
                NavigationLink(task, value: task)
            }
            .navigationDestination(for: String.self) { selectedTask in
                TaskFormView(showForm: $showForm, tasks: $tasks, task: task)
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(tasks[index])
            }
        }
    }
}

#Preview {
    ContentView()
    //        .modelContainer(for: Task.self, inMemory: true) // NEEDED WHEN PERSISTING DATA
}
