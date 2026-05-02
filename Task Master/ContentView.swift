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
    //    @Query private var tasks: [Task] // TODO: Implement storage
    @State private var tasks: [Task] = []

    @State private var showForm = false

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(tasks.sorted { $0.dueDate < $1.dueDate }) { task in
                    NavigationLink {
                        Text(
                            "Task at \(task.dueDate, format: Date.FormatStyle(date: .numeric, time: .standard))"
                        )
                    } label: {
                        HStack {
                            Text(task.name)
                            Spacer()
                            Text(
                                task.dueDate.formatted(
                                    date: .long,
                                    time: .omitted
                                )
                            )
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        showForm = true
                    } label: {
                        Label("add", systemImage: "plus")
                    }.sheet(isPresented: $showForm) {
                        NewTaskView(tasks: $tasks, showForm: $showForm)
                    }
                }
            }
        } detail: {
            Text("Select an item")
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
