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
    
    // Mocked data
    @State private var tasks: [Task] = [
        Task(name: "Dishes", dueDate: Date.now),
        Task(name: "Laundry", dueDate: Calendar.current.date(byAdding: .day, value: 7, to: Date.now)!),
        Task(name: "Vacuum", dueDate: Calendar.current.date(byAdding: .day, value: 2, to: Date.now)!)
    ]
    
    private var sortedTasks: [Task] {
        tasks.sorted { $0.dueDate < $1.dueDate }
    }

    @State private var showForm = false

    var body: some View {
        NavigationStack {
            Button("+") {
                withAnimation(.spring(duration: 0.3)) {
                    showForm = true
                }
            }
            List(sortedTasks) { task in
                NavigationLink(value: task) {
                    HStack {
                        Text(task.name)
                            .font(.headline)
                        
                        Spacer()
                        
                        Text(task.dueDate.formatted())
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationDestination(for: Task.self) { selectedTask in
                TaskFormView(task: selectedTask, onUpdate: updateTask)
            }
        }
        .sheet(isPresented: $showForm) {
            TaskFormView(onCreate: createTask)
        }
    }

    private func dismissOverlay() {
        withAnimation(.easeOut(duration: 0.2)) {
            showForm = false
            print("Dismissing")
        }
    }
    
    private func createTask(task: Task) {
        tasks.append(task)
        dismissOverlay()
    }
    
    private func updateTask(task: Task) {
        for index in tasks.indices {
            if tasks[index].id == task.id {
                tasks[index] = task
                print("Updated task")
            }
        }
    }
    
}

#Preview {
    ContentView()
    //        .modelContainer(for: Task.self, inMemory: true) // NEEDED WHEN PERSISTING DATA
}
